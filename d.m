% Domaci zadatak
% Predmet: Prepoznavanja oblika, 
% student: Ljiljana Popovic EE72/2014,
% asistent: Tijana Delic

% Žitarice
% Atributi: površina A, okolina P, kompaktnost C = 4*pi*A*P2, dužina jezgra,
% širina jezgra, koeficijent asimetrije, dužina useka u jezgru, klasa.
% Analizirati sve varijable za svaku od klasa. Npr. predvideti dužinu useka
% u jezgru.

%Ucitavanje podataka
load seeds_dataset.txt

%Podela po klasama:
zitarice = seeds_dataset; %Radi lakseg zapisa                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
klasa1 = zitarice(zitarice(:,end) == 1, :);
klasa2 = zitarice(zitarice(:,end) == 2, :);
klasa3 = zitarice(zitarice(:,end) == 3, :);
%Poredim sa brojem za svaku klasu i tako dobijam 3 razlicite klase
klasa1 = klasa1(:,1:end-1);
klasa2 = klasa2(:,1:end-1);
klasa3 = klasa3(:,1:end-1);
%Ne uzimam labelu klase kao atribut

% ANALIZA PODATAKA

%1. Ukoliko postoje nedostajuci podaci, izbaciti ih iz razmatranja
% (ukoliko nije naglašeno drugacije kod detaljnije objašnjenja baze).
nan1 = isnan(klasa1);
nan1 = sum(sum(nan1));

nan2 = isnan(klasa2);
nan2 = sum(sum(nan2));

nan3 = isnan(klasa3);
nan3 = sum(sum(nan3));
% Sa funkcijom isnan utvrdjujem da ne postoje nedostajuci podaci posto su 
% dobijene sve 0

%2. Utvrditi dinamicki i interkvartilini opseg za svaki od atributa i 
% prokomentarisati zapažanja

%Odredjivanje dinamickih opsega za svaki od atributa:
rangeKlasa1=max(klasa1)-min(klasa1);
rangeKlasa2=max(klasa2)-min(klasa2);
rangeKlasa3=max(klasa3)-min(klasa3);
%Vidimo sledece:   
%Za prvu klasu najveci dinamicki opseg je kod 6. atributa a najmanji kod 3.
%Za drugu klasu najveci dinamicki opseg je kod 1. atributaa najmanji kod 3.
%Za trecu klasu najveci dinamicki opseg je kod 6. atributa a najmanji kod 3.

%Odredjivanje interkvartilnog opsega za svaki od atributa:
iqrKlasa1=iqr(klasa1);
iqrKlasa2=iqr(klasa2);
iqrKlasa3=iqr(klasa3);
%Ovde vidimo sledece:
%Za klasu 1 najveci interkvartilni opseg je za 6. obelezje a najmanji za 3.
%Za klasu 2 najveci interkvartilni opseg je za 1. obelezje a najmanji za 3.
%Za klasu 3 najveci interkvartilni opseg je za 6. obelezje a najmanji za 3.

%3. Utvrditi da li za neke od atributa postoji vrednost koja se javlja u 
% više od 10% uzoraka.

% Posto su vrednosti podataka diskretne, radimo histogram za svaki
% atribut
for i = 1 : 7
    figure, hist1(i) = histogram(klasa1(:,i),(min(klasa1(:,i))):0.05:(max(klasa1(:,i))));
end
for i = 1 : 7
    figure, hist2(i) = histogram(klasa2(:,i),(min(klasa2(:,i))):0.05:(max(klasa2(:,i))));
end
for i = 1 : 7
    figure, hist3(i) = histogram(klasa3(:,i),(min(klasa3(:,i))):0.05:(max(klasa3(:,i))));
end

% l = length(klasa1(:,1)).*0.1;
% % 10% uzoraka je l=7 za sve klase jer svaka klasa ima 70 uzoraka

% [P1 P2] = mode(klasa1);
% % Koristim funkciju mode koja mi u P1 vraca vrednost koja se najcesce
% % pojavljuje za sve atribute a u P2 koliko se puta pojavljuje
% i = 0;
% for i1 = 1 : length(P2)
% if(P2(i1) > l )
%     i = i + 1;
% end
% end % Prolazim kroz vektor P2 i brojim koliiko atributa ima vrednost koja
% % se ponavlja u vise od 10% uzoraka


%4. Nacrtati boxplot za svaki od atributa i utvrditi da li sadrži outliere 
% ukoliko su outlieri definisani kao vrednosti vece od q3+w*(q3-q1) i manje 
% od q1+w*(q3-q1), gde je q3 gornji kvartil, q1 je donji kvartil, a w treba
% da bude jednako 1.

figure,boxplot(klasa1,'Labels',{'1','2','3','4','5','6','7'},'Whisker',1),
title('Klasa1')
xlabel('Atributi')

figure,boxplot(klasa2,'Labels',{'1','2','3','4','5','6','7'},'Whisker',1),
title('Klasa2')
xlabel('Atributi')

figure,boxplot(klasa3,'Labels',{'1','2','3','4','5','6','7'},'Whisker',1), 
title('Klasa3')
xlabel('Atributi')


%5. Potom nad podacima izvršiti z-normalizaciju, a onda uraditi sledece
% analize.
N1 = (klasa1-mean(klasa1))./std(klasa1);
N2 = (klasa2-mean(klasa2))./std(klasa2);
N3 = (klasa3-mean(klasa3))./std(klasa3);

% Z = zscore(klasa1); Postoji i ugradjena matlab-ova funkcija za
% Z-normalizaciju

%6. Utvrditi koja dva atributa imaju najvecu korelaciju.
corrKlasa1=corrplot(N1);
corrKlasa2=corrplot(N2);
corrKlasa3=corrplot(N3);

% Prvo i drugo obelezje su najvise korelisani, za prvu klasu 98%, za drugu 
% 98% i za trecu 91%

%7. Nacrtati scatterplot za ta dva atributa kao i pravu koja najbolje
%opisuje njihovu zavisnost.

cor1 = corrplot(N1(:,1:2),'varNames',{'1','2'}); 
cor2 = corrplot(N2(:,1:2),'varNames',{'1','2'});
cor3 = corrplot(N3(:,1:2),'varNames',{'1','2'});
% II nacin je preko scatter-a:
%figure scatter(N1(:,1),N1(:,2))
%hold on, lsline


%8. Svaki od atributa modelovati normalnom raspodelom

for i = 1 : 7
    x=-2:0.01:23;
    norm1=normpdf(x,mean(klasa1(:,i)),std(klasa1(:,i)));
    norm2=normpdf(x,mean(klasa2(:,i)),std(klasa2(:,i)));
    norm3=normpdf(x,mean(klasa3(:,i)),std(klasa3(:,i)));
    
    figure, plot(x,norm1,x,norm2,x,norm3),
    title('Normalna raspodela atributa')
    xlabel('x')
    axis tight
end

% Crtam na istom grafiku za svaki atribut
% Vidim da 6.obelezje ima priblizno istu srednju vrednost u sve tri klase


% Napraviti poredjenje za jedan od atributa na sledeci nacin: 
%9. Odabrati jedan od atributa i na istom grafiku za sve klase nacrtati 
% boxplot koji ga opisuje i prokomentarisati zapažanja (nad originalnim
% podacima).

%Biram 4. atribut.
klase = [klasa1(:,4) klasa2(:,4) klasa3(:,4)];
figure, boxplot(klase,'Labels',{'klasa1','klasa2','klasa3'},'Whisker',1)
title('Duzina jezgra')


%10. Na drugom grafiku nacrtati normalne raspodele kojima su modelovani u 
% svakoj od klasa i prokomentarisati zapažanja (nad normalizovanim podacima)

x=0:0.01:10;
normal1=normpdf(x,mean(klasa1(:,4)),std(klasa1(:,4)));
normal2=normpdf(x,mean(klasa2(:,4)),std(klasa2(:,4)));
normal3=normpdf(x,mean(klasa3(:,4)),std(klasa3(:,4)));
figure, plot(x,normal1,x,normal2,x,normal3)


% LINEARNA REGRESIJA

% U zavisnosti od odabranog skupa podataka, napraviti model linearne 
% regresije koji predvidja jedan od numerickih atributa.

%1. Potrebno je 10% nasumicno izabranih uzoraka ostaviti kao test skup, 
% a preostalih 90% koristiti za pravljenje modela.

% 10% uzoraka od ukupnih 210 je 21 za sve tri klase.
zita = seeds_dataset(:,1:end-1); 
ran = randperm(length(zita(:,1)));
% Funkcija randperm mi permutuje brojeve do broja do kog smo mu zadali na
% slucajan nacin bez ponavljanja 

ran = ran(:,1:21); % na ovaj nacin smo obezbedili da na slucaj izaberemo 
% koje uzorke cemo uzeti

ran = sort(ran,'descend');
test = [];
trening = zita;
for i = 1 : length(ran)
        test = [test; zita(ran(i),:)];
        trening(ran(i),:) = [];
end

%2. Koristeci RSS (Residual Sum of Squares) meru kao kriterijum i metod 
% selekcije obeležja unapred ili p-vrednost i metod selekcije obeležja 
% unazad, odrediti najbolji model linearne regresije sa 5 obeležja 
%(uz 5 razlicitih obeležja mogu postojati njihovi kvadrati ili kombinacije).

c = corrplot(zita);

for i = 2 : 7
M = fitlm(trening(:,i),trening(:,1),'linear');
   e1(i) = M.SSE;
end
e1 = e1(2:end);
e1 = min(e1);
% Na osnovu greske vidimo da kombinacija sa drugim obelezjem daje najmanju
% gresku pa njega uzimamo

for i = 3 : 7
M = fitlm(trening(:,[2 i]),trening(:,1),'linear');
   e2(i) = M.SSE;   
end
e2 = e2(3:end);
e2 = min(e2);
% Dodajem 3. obelezje

for i = 4 : 7
M = fitlm(trening(:,[2 3 i]),trening(:,1),'linear');
   e3(i) = M.SSE;   
end
e3 = e3(4:end);
e3 = min(e3);
% Dodajem 7. obelezje

for i = 4 : 6
M = fitlm(trening(:,[2 3 7 i]),trening(:,1),'linear');
   e4(i) = M.SSE;   
end
e4 = e4(4:end);
e4 = min(e4);
% Dodajem 5. obelezje

M = fitlm(trening(:,[2 3 7 5 6]),trening(:,1),'linear');
e5 = M.SSE
M = fitlm(trening(:,[2 3 7 5 4]),trening(:,1),'linear','VarNames',{'okolina_P','kompaktnost','dužina_useka_u_jezgru','širina_jezgra','dužina_jezgra','površina_A'});
e6 = M.SSE

% 4. obelezje daje manji RSS
% Dobijam model sa 5 obelezja: 2,3,7,5,4
% površina_A ~ 1 + okolina_P + kompaktnost + dužina_useka_u_jezgru + širina_jezgra + dužina_jezgra

M.Coefficients
M.plot

%3. Izvršiti predikciju nad test skupom i kao konacnu meru uspešnosti 
% modela dati MSE (sumu kvadrata razlike originalnih test podataka i
% podataka koje je predvideo tvoj konacni model linearne regresije.

 p = predict(M,test(:,[2 3 7 5 4]))

 ERR = M.MSE

 err = (p-test(:,1)).^2;
 err = sum(err)./length(test)
 
 M.Coefficients
 M.plot
 stem(M.Residuals.Raw)

 