function testWs(im)

    logIm = log(double(im));
    nIm = mat2gray(im);
    fIm = imfilter(nIm, fspecial('disk', 8));
    cells = im2bw(fIm, graythresh(fIm));

    c = figure;
    imshow(cells)
    title('cells')

    pause
    close(c)

    toWs = -fIm;
    toWs(~cells) = -Inf;

    ws = watershed(toWs);

    figure, imshow(ws, [])