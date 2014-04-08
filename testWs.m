function testWs(im)

    % the log method

    logIm = log2(double(im));
    nIm = mat2gray(logIm);
    fIm = imfilter(nIm, fspecial('disk', 12));

    section = im2bw(fIm, graythresh(fIm));
    thresh = graythresh(fIm(section))
    m = mean(fIm(section))
    stdev = std(fIm(section))
    cells = im2bw(fIm, thresh);

    figure
    imshow(im)
    alphamask(cells);
    title('cells - log')

    % no log method

    nIm = mat2gray(im);
    fIm = imfilter(nIm, fspecial('disk', 12));

    cells = im2bw(fIm, graythresh(fIm));

    figure
    imshow(im)
    alphamask(cells);
    title('cells - no log')


    pause
    close all


%    toWs = -fIm;
%    toWs(~cells) = -Inf;
%
%    ws = watershed(toWs);