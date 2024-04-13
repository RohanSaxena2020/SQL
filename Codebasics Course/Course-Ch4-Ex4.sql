SELECT *, budget, revenue, revenue-budget as profit, ((revenue-budget)/revenue)*100 as profit_margin_percent FROM financials;
