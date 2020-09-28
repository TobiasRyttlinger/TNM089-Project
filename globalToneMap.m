function [toneMap] = globalToneMap(HDR)
%UNTITLED5 Summary of this function goes here
HDRNorm=(HDR-min(HDR(:)))/(max(HDR(:))-min(HDR(:)));



L = rgb2gray(HDRNorm);


Ltemp = log(L);
N = size(HDRNorm,1) * size(HDRNorm,2);
Lavg = exp(sum(Ltemp(:))/N);


a = 0.7;
T = (a/Lavg)*L;

T2max = max(T(:))*max(T(:));

%Reinhard mapping operator
Ltone = (T(:).*(1+(T(:))./T2max))./(1+T(:));
Ltone = reshape(Ltone, [size(HDRNorm,1), size(HDRNorm,2)]);


M = Ltone(:)./L(:);
M = reshape(M, [size(HDRNorm,1), size(HDRNorm,2)]);


RHDR = HDR(:,:,1);
GHDR = HDR(:,:,2);
BHDR = HDR(:,:,3);

% for k =1:size(HDRNorm,1)
%     for l=1:size(HDRNorm,2)
%         Rnew(k,l) = M(k,l)* RHDR(k,l);
%         Gnew(k,l) = M(k,l)* GHDR(k,l);
%         Bnew(k,l) = M(k,l)* BHDR(k,l);
%     end
% end

toneMap(:,:,1) = immultiply(M,RHDR);
toneMap(:,:,2) = immultiply(M,GHDR);
toneMap(:,:,3) = immultiply(M,BHDR);
%toneMap = cat(3, Rnew, Gnew, Bnew);

gamma = 0.55;
A = 0.65;
toneMap(:,:,1) = A*toneMap(:,:,1).^gamma;
toneMap(:,:,2) = A*toneMap(:,:,2).^gamma;
toneMap(:,:,3) = A*toneMap(:,:,3).^gamma;
toneMap=(toneMap-min(toneMap(:)))/(max(toneMap(:))-min(toneMap(:)));

end

