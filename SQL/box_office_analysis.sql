-- Initial Data Cleaning and Selection
WITH BoxOfficeCleaned AS (
	SELECT
		trim("Movie Name") AS title,
		"Release Date" AS "release_date",
		"Production Budget (USD)" AS "budget",		
		CAST("Domestic Box Office (USD)" AS INT) AS "gross_domestic",
		CAST("International Box Office (USD)" AS INT) AS "gross_international",
		-- Add Domestic and Internation Gross to calculate Worldwide Gross
		(COALESCE(CAST("Domestic Box Office (USD)" AS INT), 0) + 
		COALESCE(CAST("International Box Office (USD)" AS INT), 0)) AS "gross_worldwide",
		ROUND(("Domestic Share Percentage" * 0.01), 2) AS "gross_domestic_percent",
		CAST("Infl. Adj. Dom. BO (USD)" AS INT) AS "gross_domestic_adj",
		-- Standardize the MPAA Values
		CASE
			WHEN "MPAA Rating" LIKE 'NC-17%' THEN 'NC-17'
			WHEN "MPAA Rating" IS NULL THEN 'Not Rated'
			ELSE trim("MPAA Rating")
		END AS "mpaa",
		CAST("Running Time (minutes)" AS INT) AS "runtime",
		-- Create a Franchise Boolean (1 = Franchise, 0 = Standalone)
		CASE 
			WHEN "Franchise" IS NULL OR trim("Franchise") = '' THEN 0 
			ELSE 1 
		END AS is_franchise,
		trim("Source") AS "source",
		trim("Genre") AS "genre_main",
		trim("Creative Type") AS "genre_sub",
		trim("Production Countries") AS "country",
		trim("Languages") AS "language"
	FROM 
		"Top Movies (Cleaned Data)"
	WHERE
		-- Filter for 21st Century Titles
		"Release Date" BETWEEN '2000-01-01' AND '2024-12-31'
		-- Filter Out Mislabeled 1910s and 1920s Titles using secondary metadata
		AND "Domestic Releases" NOT LIKE '%191%'
		AND "Domestic Releases" NOT LIKE '%192%'
),

-- Perform Calculations
BoxOfficeFinal AS (
		SELECT 
			title,
			release_date,
			budget,
			-- Create Budget Category
			CASE 
				WHEN budget  >= 100000000 THEN 'High-Budget ($100M+)'
				WHEN budget < 20000000 THEN 'Low-Budget (<$20M)'
				ELSE 'Mid-Budget ($20M - $99M)'
			END AS budget_class,
			gross_domestic,
			gross_international,
			gross_worldwide,
			gross_domestic_percent,
			-- Calculate International Gross Percentage
			CASE
				WHEN gross_international = 0 OR gross_international IS NULL THEN NULL
				ELSE ROUND((1.0 - COALESCE(gross_domestic_percent, 0.0)), 2)
			END AS "gross_international_percent",
			gross_domestic_adj,
			-- Calculate Adjusted Inflation for Worldwide Totals using Domestic Inflation Adjustment
			CAST(ROUND(
				((gross_domestic_adj * 1.0) / NULLIF(gross_domestic, 0) * gross_worldwide)
				) AS INT) AS gross_worldwide_adj,
			-- Calculate Estimated Profit (Breakeven Point being roughly 2.5x Budget)
			CAST(ROUND(gross_worldwide - (budget * 2.5)) AS INT) AS profit_est,
			-- Calculate Adjusted Inflation for Estimated Profit
			CAST(ROUND(
				((gross_domestic_adj * 1.0) / NULLIF(gross_domestic, 0)) * gross_worldwide
				- (2.5 * budget)
				) AS INT) AS profit_est_adj,
			-- Calculate Studio ROI (Estimated 50% Rental Share with theaters)
			ROUND((gross_worldwide * 0.5) / NULLIF(budget, 0), 2) AS roi_studio,
			-- Calculate Success Metrics
			CASE
				WHEN ROUND(gross_worldwide - (budget * 2.5)) >= 0 THEN 'Profitable'
				ELSE 'Loss'
			END AS financial_status,
			CASE 
				WHEN gross_worldwide >= (budget * 2.5) * 3.0 THEN 'Breakout Hit'
				WHEN gross_worldwide >= (budget * 2.5) THEN 'Successful'
				WHEN gross_worldwide >= (budget * 2.5) * 0.75 THEN 'Underperformed'
				ELSE 'Box Office Bomb'
			END AS performance_tier,
			mpaa,
			runtime,
			is_franchise,
			source,
			genre_main,
			genre_sub,
			country,
			language
		FROM BoxOfficeCleaned
		-- Filter Out Titles With Under $1M Worldwide Gross
		WHERE gross_worldwide >= 1000000)

-- Final Check and Sort		
SELECT *
FROM BoxOfficeFinal
ORDER BY release_date DESC;