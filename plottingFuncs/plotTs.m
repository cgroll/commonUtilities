function plotTs(tsTab)

plot(tsTab.Date, tsTab{:, 2:end})
datetick 'x'
grid on
grid minor

end