function [hdr] = HDRSolver(images, dt, gRed, gGreen, gBlue)
    zMid = 128;
    zMax = 256;
    
    % If Z >Zmid: w = Zmax -Z 
    accumulator = zeros(size(images{1}));
    hdr = zeros(size(images{1}));
    sum = zeros(size(images{1}));
    
    for i=1:size(images,2)
        
        im = double(images{i});
        
        zred= im(:,:,1);
        wr=zred;          
        wr(zred>zMid)=zMax-zred(zred>zMid); 
        
        
        
        zgreen= im(:,:,2);
        wg=zgreen;          
        wg(zgreen>zMid)=zMax-zgreen(zgreen>zMid); 
        
        zblue= im(:,:,3);
        wb=zblue;          
        wb(zblue>zMid)=zMax-zblue(zblue>zMid); 
        
        w = cat(3, wr,wg,wb);
        
        accumulator(:,:,1) = wr.*reshape(gRed(zred+1)-dt(1,i), size(zred)); % add g(Zij)-log(tj) to accumulator image
        accumulator(:,:,2) = wg.*reshape(gGreen(zgreen+1)-dt(1,i), size(zgreen));
        accumulator(:,:,3) = wb.*reshape(gBlue(zblue+1)-dt(1,i), size(zblue));
        
        hdr = hdr + accumulator;
        sum = sum + w;
        
    end
   hdr = hdr./sum;
   max(max(sum));
   hdr = exp(hdr);
    %ekv 6


end
