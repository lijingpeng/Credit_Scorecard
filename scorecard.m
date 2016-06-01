load CreditCardData
sc = creditscorecard(data,'IDVar','CustID');
bininfo(sc,'ResStatus')
plotbins(sc,'ResStatus')

cp = 20000:5000:60000;
sc = modifybins(sc,'CustIncome','CutPoints',cp);
bininfo(sc,'CustIncome')
plotbins(sc,'CustIncome')
sc = autobinning(sc);
[bi,cp] = bininfo(sc,'CustAge');
cp([1 5]) = []; % To merge bins 1 and 2, and bins 5 and 6
sc = modifybins(sc,'CustAge','CutPoints',cp);
plotbins(sc,'CustAge')
[bi,cp] = bininfo(sc,'CustIncome');
cp([3 4]) = [];
sc = modifybins(sc,'CustIncome','CutPoints',cp);
plotbins(sc,'CustIncome')
[bi,cp] = bininfo(sc,'TmWBank');
cp(2) = [];
sc = modifybins(sc,'TmWBank','CutPoints',cp);
plotbins(sc,'TmWBank')
[bi,cp] = bininfo(sc,'AMBalance');
cp(2) = [];
sc = modifybins(sc,'AMBalance','CutPoints',cp);
plotbins(sc,'AMBalance')

sc = fitmodel(sc);
p1 = displaypoints(sc);
disp(p1)
sc = modifybins(sc,'CustAge','BinLabels',...
{'Up to 36' '37 to 39' '40 to 45' '46 to 57' '58 and up'});

sc = modifybins(sc,'CustIncome','BinLabels',...
{'Up to 28999' '29000 to 32999' '33000 to 41999' '42000 to 46999' '47000 and up'});

sc = modifybins(sc,'TmWBank','BinLabels',...
{'Up to 11' '12 to 44' '45 to 70' '71 and up'});

sc = modifybins(sc,'AMBalance','BinLabels',...
{'Up to 558.87' '558.88 to 1597.43' '1597.44 and up'});

p1 = displaypoints(sc);
disp(p1)

TargetPoints = 500;
TargetOdds = 2;
PDO = 50; % Points to double the odds

sc = formatpoints(sc,'PointsOddsAndPDO',[TargetPoints TargetOdds PDO],'Round','AllPoints');
p2 = displaypoints(sc);
disp(p2)
[Scores,Points] = score(sc);
disp(Scores(1:10))
disp(Points(1:10,:))

[Stats,T] = validatemodel(sc,'Plot',{'CAP','ROC','KS'});
disp(Stats)
disp(T(1:15,:))
