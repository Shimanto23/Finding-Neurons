img = imread('Neurons.jpg');
figure(1), clf
imshow(img)
img = squeeze(mean( img(1073:2335,2180:3803,:) ,3));
imagesc(img), axis image
colormap gray
figure(2), clf
histogram(img(:),600)
thresh = 200;
threshmap = img<thresh;
units = bwconncomp(threshmap);
imagesc(img), hold on
contour(threshmap,1,'r')
axis image
colormap gray
zoom on

unitsizes = cellfun(@length,units.PixelIdxList);
figure(3), clf
histogram(unitsizes,1600)
set(gca,'xlim',[0 350])
xlabel('Unit size (pixels)'), ylabel('Count')
pixthresh = 8;
threshmapFilt = false(size(threshmap));

for ui=1:units.NumObjects
    
    if unitsizes(ui)<pixthresh
        continue;
    end
    threshmapFilt(units.PixelIdxList{ui}) = 1;
end

figure(4)
contour(threshmapFilt,1,'g','linew',2)
sizecolormap = nan(size(img));

for ui=1:units.NumObjects
    sizecolormap(units.PixelIdxList{ui}) = unitsizes(ui);
end

alphmap = ones(size(img));
alphmap;
figure(5), clf
imagesc(sizecolormap)
set(gca,'clim',[0 10])