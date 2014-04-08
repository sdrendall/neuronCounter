function [labIm, neurons] = findNeurons(im)
    %% [labIm, neurons] = findNeurons(im)
    % Attempts to find neurons in an fish section

    % Extract green layer
    green = im(:,:,2);
    % Log2 -- probably a better way to accentuate image
    logIm = log2(green);

    % segment -- should reveal section
    filtIm = imfilter(logIm, fspecial('disk', 12));
    section = im2bw(filtIm, graythresh(filtIm));

    % segment -- for cells (or a big mess if no cells are present)
    cells = im2bw(filtIm(section), graythresh(filtIm(section)));

    % label cells and get properties
    cells = bwlabel(cells);
    cellProps = regionprops(cells);

    % find cells that are too large or misshapen
    % thresholds here are determined somewhat arbitrarily
    imArea = size(green, 1) * size(green, 2);
    tooLarge = [cellProps(:).Area] >= imArea/5;
    axisRatio = [cellProps(:).MajorAxisLength]./[cellProps(:).MinorAxisLength];
    tooLong = axisRatio >= 5;
    boundingArea = [cellProps(:).MajorAxisLength].*[cellProps(:).MinorAxisLength];
    percentFilled = [cellProps(:).Area]./boundingArea;
    tooSparse = percentFilled <= 20;

    % Union disqualifiers
    disqualifiedCells = tooLarge || tooLong || tooSparse;

    % Remove cells
    [cells, cellProps] = removeCells(cells, cellProps, disqualifiedCells);

    % Watershed cells
    [labIm, neurons] = watershedCells(cells);

    % Remove uninteresting neurons
    