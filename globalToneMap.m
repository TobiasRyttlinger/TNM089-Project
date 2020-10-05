function [toneMap] = globalToneMap(HDR)
%UNTITLED5 Summary of this function goes here
HDRNorm=(HDR-min(HDR(:)))/(max(HDR(:))-min(HDR(:)));
L = rgb2gray(HDRNorm);
gamma = 1;
A = 1;
HDRNorm(:,:,1) = A*HDRNorm(:,:,1).^gamma;
HDRNorm(:,:,2) = A*HDRNorm(:,:,2).^gamma;
HDRNorm(:,:,3) = A*HDRNorm(:,:,3).^gamma;

Ltemp = log(L);
N = size(HDRNorm,1) * size(HDRNorm,2);
Lavg = exp(sum(Ltemp)/N);


a = 0.7;
T = (a./Lavg).*L;

T2max = max(T(:))*max(T(:));

%Reinhard mapping operator
Ltone = (T.*(1+T./T2max))./(1+T);



M = Ltone./L;


imshow(M)


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


toneMap=(toneMap-min(toneMap(:)))/(max(toneMap(:))-min(toneMap(:)));

end

