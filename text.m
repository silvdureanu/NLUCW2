en = "NLUCW2/raw_data/train.en";
enstr = extractFileText(en);
ensents = splitlines(enstr);
jp = "NLUCW2/raw_data/train.jp";
jpstr = extractFileText(jp);
jpsents = splitlines(jpstr);
ensents(end)=[];
jpsents(end)=[];

length(ensents);

entypes = containers.Map;
jptypes = containers.Map;

for i=1:length(ensents)
    spl = split(ensents(i));
    enlen(i)=length(spl);
    for j=1:length(spl)
        if isKey(entypes,spl(j))
            entypes(spl(j)) = entypes(spl(j))+1;
        else
            entypes(spl(j)) = 1;
        end
    end
end

for i=1:length(jpsents)
    spl = split(jpsents(i));
    jplen(i)=length(spl);
    for j=1:length(spl)
        if isKey(jptypes,spl(j))
            jptypes(spl(j)) = jptypes(spl(j))+1;
        else
            jptypes(spl(j)) = 1;
        end
    end

end

entokens = sum(enlen);
jptokens = sum(jplen);

entypenums = cell2mat(values(entypes));
jptypenums = cell2mat(values(jptypes));

entypes = length(entypenums);
jptypes = length(jptypenums);

ennumunk = sum(entypenums==1);
jpnumunk = sum(jptypenums==1);

binranges=0:40;
[enbins]=histc(enlen,binranges);
bar(binranges,enbins,'histc');
xlabel("Sentence length");
ylabel("Number of sentences");
title("English sentence length distribution");

figure(2)
[jpbins]=histc(jplen,binranges);
bar(binranges,jpbins,'histc');
xlabel("Sentence length");
ylabel("Number of sentences");
title("Japanese sentence length distribution");

figure(3)
plot(enlen,jplen);
xlabel("English sentence lengths");
ylabel("Japanese sentence lengths");

