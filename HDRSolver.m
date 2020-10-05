function [hdr] = HDRSolver(images, dt, gRed, gGreen, gBlue)
    zMid = 128;
    zMax = 256;
    
    % If Z >Zmid: w = Zmax -Z 
    accumulator = zeros(size(images{1}));
    hdr = zeros(size(images{1}));
    summ = zeros(size(images{1}));
     
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
        
        accumulator(:,:,1) = wr.*reshape(gRed(zred+1)-dt(1,i), size(zred)); 
        accumulator(:,:,2) = wg.*reshape(gGreen(zgreen+1)-dt(1,i), size(zgreen));
        accumulator(:,:,3) = wb.*reshape(gBlue(zblue+1)-dt(1,i), size(zblue));
        
        hdr = hdr + accumulator;
        summ = summ + w;
        
    end
    
   zeroIndR = find(summ(:,:,1)==0);
   zeroIndG = find(summ(:,:,2)==0);
   zeroIndB = find(summ(:,:,3)==0);
   realMin = 0.001;
   
   [width, height, ~] = size(summ);
  
   summR = reshape(summ(:,:,1), [1,width*height]);
   summG = reshape(summ(:,:,2), [1,width*height]);
   summB = reshape(summ(:,:,3), [1,width*height]);
   
   summR(zeroIndR) = realmin;
   summG(zeroIndR) = realmin;
   summB(zeroIndR) = realmin;
   
   
   summR = reshape(summR, [width, height]);
   summG = reshape(summG, [width, height]);
   summB = reshape(summB, [width, height]);
   
   summa = cat(3,summR, summG, summB);
   
   hdr = hdr./summa;
 
   hdr = exp(hdr);
    %ekv 6


end
