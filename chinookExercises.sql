-- 1. non_usa_customers.sql

SELECT c.FirstName
	,c.LastName
	,c.CustomerId
	,c.Country
FROM Customer c
WHERE Country != 'USA';

-- 2. brazil_customers.sql

SELECT c.FirstName
	,c.LastName
	,c.CustomerId
	,c.Country
FROM Customer c
WHERE Country = 'Brazil';

-- 3. brazil_customers_invoices.sql

SELECT c.FirstName
	,c.LastName
	,InvoiceId
	,i.InvoiceDate
	,i.BillingCountry
FROM Customer c
INNER JOIN Invoice i on i.CustomerId = c.CustomerId
WHERE Country = 'Brazil';

-- 4. sales_agents.sql

SELECT *
FROM Employee
WHERE Title = 'Sales Support Agent';

-- 5. unique_invoice_countries.sql

SELECT i.BillingCountry
FROM Invoice i
GROUP BY i.BillingCountry;

-- 6. sales_agent_Invoices.sql

SELECT e.FirstName || ' ' || e.LastName [Sales Agent]
	,i.*
FROM Customer c
JOIN Employee e on e.EmployeeId = c.SupportRepId
JOIN Invoice i on i.CustomerId = c.CustomerId;

-- 7. invoice_totals.sql

SELECT i.[Total]
	,c.FirstName || ' ' || c.LastName [Customer Name]
	,i.BillingCountry
	,e.FirstName || ' ' || e.LastName [Sales Agent]
FROM Customer c
JOIN Employee e on e.EmployeeId = c.SupportRepId
JOIN Invoice i on i.CustomerId = c.CustomerId;

-- 8. total_invoices_[year].sql

SELECT Count(i.InvoiceId) 'Invoices from 2009/2011'
FROM Invoice i
WHERE strftime('%Y',i.InvoiceDate) in ('2009', '2011');

-- 9. total_sales_{year}.sql

SELECT strftime('%Y',i.InvoiceDate) 'Year'
	,Sum(Total) 'Total Sales'
FROM Invoice i
WHERE strftime('%Y',i.InvoiceDate) in ('2009', '2011')
GROUP BY strftime('%Y',i.InvoiceDate);

-- 10. invoice_37_line_item_count.sql

SELECT i.InvoiceId
	,Count(il.InvoiceLineId) NumOfLineItems
FROM Invoice i
JOIN InvoiceLine il on il.InvoiceId = i.InvoiceId
WHERE i.InvoiceId = 37
GROUP BY i.InvoiceId;

-- 11. line_items_per_invoice

SELECT i.InvoiceId
	,Count(il.InvoiceLineId) NumOfLineItems
FROM Invoice i
JOIN InvoiceLine il on il.InvoiceId = i.InvoiceId
GROUP BY i.InvoiceId;

-- 12. line_item_track.sql

SELECT il.*
	,t.Name as TrackName
FROM InvoiceLine il
JOIN Track t on t.TrackId = il.TrackId;

-- 13. line_item_track_artist.sql

SELECT il.*
	,t.Name TrackName
	,art.Name ArtistName
FROM InvoiceLine il
JOIN Track t on t.TrackId = il.TrackId
	JOIN Album a on a.AlbumId = t.AlbumId
		JOIN Artist art on art.ArtistId = a.ArtistId;
		
-- 14. country_invoices.sql

SELECT i.BillingCountry
	,Count(i.InvoiceId) CountOfInvoices
FROM Invoice i
GROUP BY i.BillingCountry;

--15. playlist_track_count.sql

SELECT p.Name PlayListName
	,Count(pt.TrackId) NumOfTracks
FROM Playlist p
	JOIN PlaylistTrack pt on pt.PlaylistId = p.PlaylistId
		JOIN Track t on t.TrackId = pt.TrackId
GROUP BY p.Name;

-- 16. tracks_no__id.sql

SELECT t.Name as TrackName
	,a.Title as [Album]
	,mt.Name as [MediaType]
	,g.Name as [Genre]
FROM Track t
JOIN Album a on a.AlbumId = t.AlbumId
JOIN MediaType mt on mt.MediaTypeId = t.MediaTypeId
JOIN Genre g on g.GenreId = t.GenreId;

-- 17. invoices_line_item_count.sql

SELECT i.InvoiceId
	,i.InvoiceDate
	,i.BillingAddress
	,i.BillingCity
	,i.BillingState
	,i.BillingCountry
	,i.BillingPostalCode
	,i.Total
	,Count(il.InvoiceLineId) NumOfLineItems
FROM Invoice i
JOIN InvoiceLine il on il.InvoiceId = i.InvoiceId
GROUP BY i.InvoiceId
	,i.InvoiceDate
	,i.BillingAddress
	,i.BillingCity
	,i.BillingState
	,i.BillingCountry
	,i.BillingPostalCode
	,i.Total;
	
-- 18. sales_agent_total_sales.sql

SELECT e.FirstName || ' ' || e.LastName [Sales Agent]
	,'$' || Round(Sum(i.Total),2) Sales
FROM Customer c
JOIN Employee e on e.EmployeeId = c.SupportRepId
JOIN Invoice i on i.CustomerId = c.CustomerId
GROUP BY e.FirstName || ' ' || e.LastName;

-- 19. top_2009_agent.sql

SELECT e.FirstName || ' ' || e.LastName [Sales Agent]
	,'$' || Round(Sum(i.Total),2) Sales
FROM Customer c
JOIN Employee e on e.EmployeeId = c.SupportRepId
JOIN Invoice i on i.CustomerId = c.CustomerId
WHERE strftime('%Y',i.InvoiceDate) = '2009'
GROUP BY e.FirstName || ' ' || e.LastName
ORDER BY 2 desc
LIMIT 1;

-- 20. top_agent.sql

SELECT e.FirstName || ' ' || e.LastName [Sales Agent]
	,'$' || Round(Sum(i.Total),2) Sales
FROM Customer c
JOIN Employee e on e.EmployeeId = c.SupportRepId
JOIN Invoice i on i.CustomerId = c.CustomerId
GROUP BY e.FirstName || ' ' || e.LastName
ORDER BY 2 desc
LIMIT 1;

-- 21. sales_agent_customer_count.sql

SELECT e.FirstName || ' ' || e.LastName [Sales Agent]
	,Count(c.CustomerId) CustomersAssigned
FROM Customer c
JOIN Employee e on e.EmployeeId = c.SupportRepId
GROUP BY e.FirstName || ' ' || e.LastName;

-- 22. sales_per_country.sql

SELECT i.BillingCountry
	,Sum(i.Total) Sales
FROM Invoice i
GROUP BY i.BillingCountry;

-- 23. top_country.sql

SELECT i.BillingCountry
	,Sum(i.Total) Sales
FROM Invoice i
GROUP BY i.BillingCountry
ORDER BY 2 desc
LIMIT 1;

-- 24. top_2013_track.sq

SELECT t.Name
	,Sum(il.Quantity) NumSold
FROM InvoiceLine il
JOIN Invoice i on i.InvoiceId = il.InvoiceId
JOIN Track t on t.TrackId = il.TrackId
WHERE strftime('%Y',i.InvoiceDate) = '2013'
GROUP BY t.TrackId, t.Name
ORDER BY 2 desc
LIMIT 1;

-- 25. top_5_tracks.sql

SELECT t.Name
	,Sum(il.Quantity) NumSold
FROM InvoiceLine il
JOIN Track t on t.TrackId = il.TrackId
GROUP BY il.TrackId, t.Name
ORDER BY 2 desc
LIMIT 5;

-- 26. top_3_artists.sql

SELECT art.Name Artist
	,Sum(il.Quantity) Sales
FROM InvoiceLine il
JOIN Track t on t.TrackId = il.TrackId
	JOIN Album a on a.AlbumId = t.AlbumId
		JOIN Artist art on art.ArtistId = a.ArtistId
GROUP BY art.Name
ORDER BY 2 desc
LIMIT 3;

-- 27. top_media_type.sql

SELECT mt.Name Artist
	,Sum(il.Quantity) Sales
FROM InvoiceLine il
JOIN Track t on t.TrackId = il.TrackId
	JOIN MediaType mt on mt.MediaTypeId = t.MediaTypeId
GROUP BY mt.Name
ORDER BY 2 desc
LIMIT 1;

































