return {
	"goolord/alpha-nvim",
	dependencies = {
		"echasnovski/mini.icons",
	},

	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.opts.hl = {
			{
				{ "I2A0", 0, 3 },
				{ "I2A0", 3, 6 },
				{ "I2A0", 6, 9 },
				{ "I2A0", 9, 12 },
				{ "I2A0", 12, 15 },
				{ "I2A0", 15, 18 },
				{ "I2A0", 18, 21 },
				{ "I2A0", 21, 24 },
				{ "I2A0", 24, 27 },
				{ "I2A0", 27, 30 },
				{ "I2A0", 30, 33 },
				{ "I2A0", 33, 36 },
				{ "I2A0", 36, 39 },
				{ "I2A0", 39, 42 },
				{ "I2A0", 42, 45 },
				{ "I2A0", 45, 48 },
				{ "I2A0", 48, 51 },
				{ "I2A0", 51, 54 },
				{ "I2A0", 54, 57 },
				{ "I2A0", 57, 60 },
				{ "I2A0", 60, 63 },
				{ "I2A0", 63, 66 },
				{ "I2A0", 66, 69 },
				{ "I2A0", 69, 72 },
				{ "I2A0", 72, 75 },
				{ "I2A0", 75, 78 },
				{ "I2A0", 78, 81 },
				{ "I2A0", 81, 84 },
				{ "I2A0", 84, 87 },
				{ "I2A0", 87, 90 },
				{ "I2A0", 90, 93 },
				{ "I2A0", 93, 96 },
				{ "I2A0", 96, 99 },
				{ "I2A0", 99, 102 },
				{ "I2A0", 102, 105 },
				{ "I2A0", 105, 108 },
				{ "I2A0", 108, 111 },
			},
			{
				{ "I2A1", 0, 3 },
				{ "I2A2", 3, 6 },
				{ "I2A2", 6, 9 },
				{ "I2A2", 9, 12 },
				{ "I2A2", 12, 15 },
				{ "I2A2", 15, 18 },
				{ "I2A2", 18, 21 },
				{ "I2A2", 21, 24 },
				{ "I2A2", 24, 27 },
				{ "I2A2", 27, 30 },
				{ "I2A2", 30, 33 },
				{ "I2A2", 33, 36 },
				{ "I2A2", 36, 39 },
				{ "I2A3", 39, 42 },
				{ "I2A4", 42, 45 },
				{ "I2A5", 45, 48 },
				{ "I2A6", 48, 51 },
				{ "I2A7", 51, 54 },
				{ "I2A8", 54, 57 },
				{ "I2A4", 57, 60 },
				{ "I2A9", 60, 63 },
				{ "I2A2", 63, 66 },
				{ "I2A2", 66, 69 },
				{ "I2A10", 69, 72 },
				{ "I2A2", 72, 75 },
				{ "I2A2", 75, 78 },
				{ "I2A2", 78, 81 },
				{ "I2A2", 81, 84 },
				{ "I2A2", 84, 87 },
				{ "I2A2", 87, 90 },
				{ "I2A2", 90, 93 },
				{ "I2A2", 93, 96 },
				{ "I2A11", 96, 99 },
				{ "I2A12", 99, 102 },
				{ "I2A12", 102, 105 },
				{ "I2A13", 105, 108 },
				{ "I2A12", 108, 111 },
			},
			{
				{ "I2A2", 0, 3 },
				{ "I2A2", 3, 6 },
				{ "I2A2", 6, 9 },
				{ "I2A2", 9, 12 },
				{ "I2A2", 12, 15 },
				{ "I2A2", 15, 18 },
				{ "I2A2", 18, 21 },
				{ "I2A2", 21, 24 },
				{ "I2A2", 24, 27 },
				{ "I2A2", 27, 30 },
				{ "I2A2", 30, 33 },
				{ "I2A2", 33, 36 },
				{ "I2A14", 36, 39 },
				{ "I2A15", 39, 42 },
				{ "I2A16", 42, 45 },
				{ "I2A17", 45, 48 },
				{ "I2A2", 48, 51 },
				{ "I2A2", 51, 54 },
				{ "I2A18", 54, 57 },
				{ "I2A19", 57, 60 },
				{ "I2A20", 60, 63 },
				{ "I2A21", 63, 66 },
				{ "I2A2", 66, 69 },
				{ "I2A2", 69, 72 },
				{ "I2A22", 72, 75 },
				{ "I2A22", 75, 78 },
				{ "I2A2", 78, 81 },
				{ "I2A2", 81, 84 },
				{ "I2A2", 84, 87 },
				{ "I2A23", 87, 90 },
				{ "I2A2", 90, 93 },
				{ "I2A2", 93, 96 },
				{ "I2A2", 96, 99 },
				{ "I2A2", 99, 102 },
				{ "I2A2", 102, 105 },
				{ "I2A2", 105, 108 },
				{ "I2A2", 108, 111 },
			},
			{
				{ "I2A24", 0, 3 },
				{ "I2A25", 3, 6 },
				{ "I2A2", 6, 9 },
				{ "I2A2", 9, 12 },
				{ "I2A2", 12, 15 },
				{ "I2A2", 15, 18 },
				{ "I2A2", 18, 21 },
				{ "I2A2", 21, 24 },
				{ "I2A2", 24, 27 },
				{ "I2A2", 27, 30 },
				{ "I2A2", 30, 33 },
				{ "I2A26", 33, 36 },
				{ "I2A27", 36, 39 },
				{ "I2A27", 39, 42 },
				{ "I2A28", 42, 45 },
				{ "I2A29", 45, 48 },
				{ "I2A30", 48, 51 },
				{ "I2A31", 51, 54 },
				{ "I2A32", 54, 57 },
				{ "I2A33", 57, 60 },
				{ "I2A34", 60, 63 },
				{ "I2A35", 63, 66 },
				{ "I2A27", 66, 69 },
				{ "I2A36", 69, 72 },
				{ "I2A2", 72, 75 },
				{ "I2A2", 75, 78 },
				{ "I2A37", 78, 81 },
				{ "I2A38", 81, 84 },
				{ "I2A2", 84, 87 },
				{ "I2A2", 87, 90 },
				{ "I2A2", 90, 93 },
				{ "I2A2", 93, 96 },
				{ "I2A2", 96, 99 },
				{ "I2A2", 99, 102 },
				{ "I2A38", 102, 105 },
				{ "I2A22", 105, 108 },
				{ "I2A39", 108, 111 },
			},
			{
				{ "I2A40", 0, 3 },
				{ "I2A41", 3, 6 },
				{ "I2A42", 6, 9 },
				{ "I2A43", 9, 12 },
				{ "I2A40", 12, 15 },
				{ "I2A42", 15, 18 },
				{ "I2A44", 18, 21 },
				{ "I2A45", 21, 24 },
				{ "I2A46", 24, 27 },
				{ "I2A46", 27, 30 },
				{ "I2A46", 30, 33 },
				{ "I2A27", 33, 36 },
				{ "I2A27", 36, 39 },
				{ "I2A47", 39, 42 },
				{ "I2A48", 42, 45 },
				{ "I2A2", 45, 48 },
				{ "I2A2", 48, 51 },
				{ "I2A1", 51, 54 },
				{ "I2A2", 54, 57 },
				{ "I2A2", 57, 60 },
				{ "I2A49", 60, 63 },
				{ "I2A50", 63, 66 },
				{ "I2A47", 66, 69 },
				{ "I2A7", 69, 72 },
				{ "I2A51", 72, 75 },
				{ "I2A52", 75, 78 },
				{ "I2A52", 78, 81 },
				{ "I2A53", 81, 84 },
				{ "I2A54", 84, 87 },
				{ "I2A55", 87, 90 },
				{ "I2A56", 90, 93 },
				{ "I2A57", 93, 96 },
				{ "I2A2", 96, 99 },
				{ "I2A58", 99, 102 },
				{ "I2A59", 102, 105 },
				{ "I2A60", 105, 108 },
				{ "I2A61", 108, 111 },
			},
			{
				{ "I2A62", 0, 3 },
				{ "I2A62", 3, 6 },
				{ "I2A63", 6, 9 },
				{ "I2A63", 9, 12 },
				{ "I2A63", 12, 15 },
				{ "I2A62", 15, 18 },
				{ "I2A64", 18, 21 },
				{ "I2A63", 21, 24 },
				{ "I2A64", 24, 27 },
				{ "I2A62", 27, 30 },
				{ "I2A65", 30, 33 },
				{ "I2A66", 33, 36 },
				{ "I2A67", 36, 39 },
				{ "I2A68", 39, 42 },
				{ "I2A69", 42, 45 },
				{ "I2A70", 45, 48 },
				{ "I2A2", 48, 51 },
				{ "I2A2", 51, 54 },
				{ "I2A71", 54, 57 },
				{ "I2A50", 57, 60 },
				{ "I2A50", 60, 63 },
				{ "I2A72", 63, 66 },
				{ "I2A73", 66, 69 },
				{ "I2A74", 69, 72 },
				{ "I2A75", 72, 75 },
				{ "I2A75", 75, 78 },
				{ "I2A76", 78, 81 },
				{ "I2A77", 81, 84 },
				{ "I2A50", 84, 87 },
				{ "I2A50", 87, 90 },
				{ "I2A78", 90, 93 },
				{ "I2A79", 93, 96 },
				{ "I2A80", 96, 99 },
				{ "I2A81", 99, 102 },
				{ "I2A82", 102, 105 },
				{ "I2A83", 105, 108 },
				{ "I2A84", 108, 111 },
			},
			{
				{ "I2A83", 0, 3 },
				{ "I2A83", 3, 6 },
				{ "I2A85", 6, 9 },
				{ "I2A86", 9, 12 },
				{ "I2A87", 12, 15 },
				{ "I2A88", 15, 18 },
				{ "I2A87", 18, 21 },
				{ "I2A89", 21, 24 },
				{ "I2A90", 24, 27 },
				{ "I2A91", 27, 30 },
				{ "I2A92", 30, 33 },
				{ "I2A93", 33, 36 },
				{ "I2A94", 36, 39 },
				{ "I2A95", 39, 42 },
				{ "I2A96", 42, 45 },
				{ "I2A97", 45, 48 },
				{ "I2A98", 48, 51 },
				{ "I2A99", 51, 54 },
				{ "I2A100", 54, 57 },
				{ "I2A69", 57, 60 },
				{ "I2A101", 60, 63 },
				{ "I2A75", 63, 66 },
				{ "I2A102", 66, 69 },
				{ "I2A103", 69, 72 },
				{ "I2A104", 72, 75 },
				{ "I2A105", 75, 78 },
				{ "I2A50", 78, 81 },
				{ "I2A106", 81, 84 },
				{ "I2A50", 84, 87 },
				{ "I2A50", 87, 90 },
				{ "I2A50", 90, 93 },
				{ "I2A107", 93, 96 },
				{ "I2A50", 96, 99 },
				{ "I2A108", 99, 102 },
				{ "I2A83", 102, 105 },
				{ "I2A109", 105, 108 },
				{ "I2A109", 108, 111 },
			},
			{
				{ "I2A98", 0, 3 },
				{ "I2A110", 3, 6 },
				{ "I2A98", 6, 9 },
				{ "I2A98", 9, 12 },
				{ "I2A111", 12, 15 },
				{ "I2A112", 15, 18 },
				{ "I2A113", 18, 21 },
				{ "I2A27", 21, 24 },
				{ "I2A27", 24, 27 },
				{ "I2A27", 27, 30 },
				{ "I2A27", 30, 33 },
				{ "I2A114", 33, 36 },
				{ "I2A75", 36, 39 },
				{ "I2A75", 39, 42 },
				{ "I2A115", 42, 45 },
				{ "I2A116", 45, 48 },
				{ "I2A117", 48, 51 },
				{ "I2A115", 51, 54 },
				{ "I2A118", 54, 57 },
				{ "I2A75", 57, 60 },
				{ "I2A119", 60, 63 },
				{ "I2A120", 63, 66 },
				{ "I2A50", 66, 69 },
				{ "I2A50", 69, 72 },
				{ "I2A50", 72, 75 },
				{ "I2A50", 75, 78 },
				{ "I2A50", 78, 81 },
				{ "I2A50", 81, 84 },
				{ "I2A50", 84, 87 },
				{ "I2A50", 87, 90 },
				{ "I2A50", 90, 93 },
				{ "I2A50", 93, 96 },
				{ "I2A50", 96, 99 },
				{ "I2A121", 99, 102 },
				{ "I2A122", 102, 105 },
				{ "I2A123", 105, 108 },
				{ "I2A110", 108, 111 },
			},
			{
				{ "I2A98", 0, 3 },
				{ "I2A98", 3, 6 },
				{ "I2A98", 6, 9 },
				{ "I2A124", 9, 12 },
				{ "I2A125", 12, 15 },
				{ "I2A126", 15, 18 },
				{ "I2A27", 18, 21 },
				{ "I2A127", 21, 24 },
				{ "I2A128", 24, 27 },
				{ "I2A129", 27, 30 },
				{ "I2A130", 30, 33 },
				{ "I2A75", 33, 36 },
				{ "I2A75", 36, 39 },
				{ "I2A75", 39, 42 },
				{ "I2A131", 42, 45 },
				{ "I2A132", 45, 48 },
				{ "I2A75", 48, 51 },
				{ "I2A75", 51, 54 },
				{ "I2A75", 54, 57 },
				{ "I2A133", 57, 60 },
				{ "I2A134", 60, 63 },
				{ "I2A134", 63, 66 },
				{ "I2A134", 66, 69 },
				{ "I2A134", 69, 72 },
				{ "I2A135", 72, 75 },
				{ "I2A136", 75, 78 },
				{ "I2A50", 78, 81 },
				{ "I2A50", 81, 84 },
				{ "I2A137", 84, 87 },
				{ "I2A138", 87, 90 },
				{ "I2A139", 90, 93 },
				{ "I2A50", 93, 96 },
				{ "I2A140", 96, 99 },
				{ "I2A50", 99, 102 },
				{ "I2A141", 102, 105 },
				{ "I2A142", 105, 108 },
				{ "I2A143", 108, 111 },
			},
			{
				{ "I2A98", 0, 3 },
				{ "I2A98", 3, 6 },
				{ "I2A144", 6, 9 },
				{ "I2A145", 9, 12 },
				{ "I2A146", 12, 15 },
				{ "I2A147", 15, 18 },
				{ "I2A50", 18, 21 },
				{ "I2A50", 21, 24 },
				{ "I2A50", 24, 27 },
				{ "I2A50", 27, 30 },
				{ "I2A148", 30, 33 },
				{ "I2A149", 33, 36 },
				{ "I2A150", 36, 39 },
				{ "I2A130", 39, 42 },
				{ "I2A75", 42, 45 },
				{ "I2A75", 45, 48 },
				{ "I2A75", 48, 51 },
				{ "I2A151", 51, 54 },
				{ "I2A152", 54, 57 },
				{ "I2A153", 57, 60 },
				{ "I2A154", 60, 63 },
				{ "I2A2", 63, 66 },
				{ "I2A155", 66, 69 },
				{ "I2A156", 69, 72 },
				{ "I2A157", 72, 75 },
				{ "I2A158", 75, 78 },
				{ "I2A50", 78, 81 },
				{ "I2A50", 81, 84 },
				{ "I2A50", 84, 87 },
				{ "I2A50", 87, 90 },
				{ "I2A50", 90, 93 },
				{ "I2A50", 93, 96 },
				{ "I2A50", 96, 99 },
				{ "I2A159", 99, 102 },
				{ "I2A50", 102, 105 },
				{ "I2A160", 105, 108 },
				{ "I2A161", 108, 111 },
			},
			{
				{ "I2A98", 0, 3 },
				{ "I2A162", 3, 6 },
				{ "I2A163", 6, 9 },
				{ "I2A164", 9, 12 },
				{ "I2A50", 12, 15 },
				{ "I2A165", 15, 18 },
				{ "I2A50", 18, 21 },
				{ "I2A50", 21, 24 },
				{ "I2A50", 24, 27 },
				{ "I2A50", 27, 30 },
				{ "I2A50", 30, 33 },
				{ "I2A166", 33, 36 },
				{ "I2A134", 36, 39 },
				{ "I2A75", 39, 42 },
				{ "I2A75", 42, 45 },
				{ "I2A167", 45, 48 },
				{ "I2A168", 48, 51 },
				{ "I2A169", 51, 54 },
				{ "I2A170", 54, 57 },
				{ "I2A171", 57, 60 },
				{ "I2A1", 60, 63 },
				{ "I2A172", 63, 66 },
				{ "I2A173", 66, 69 },
				{ "I2A174", 69, 72 },
				{ "I2A75", 72, 75 },
				{ "I2A75", 75, 78 },
				{ "I2A175", 78, 81 },
				{ "I2A50", 81, 84 },
				{ "I2A50", 84, 87 },
				{ "I2A50", 87, 90 },
				{ "I2A50", 90, 93 },
				{ "I2A50", 93, 96 },
				{ "I2A176", 96, 99 },
				{ "I2A177", 99, 102 },
				{ "I2A178", 102, 105 },
				{ "I2A179", 105, 108 },
				{ "I2A180", 108, 111 },
			},
			{
				{ "I2A98", 0, 3 },
				{ "I2A98", 3, 6 },
				{ "I2A181", 6, 9 },
				{ "I2A182", 9, 12 },
				{ "I2A183", 12, 15 },
				{ "I2A184", 15, 18 },
				{ "I2A50", 18, 21 },
				{ "I2A50", 21, 24 },
				{ "I2A185", 24, 27 },
				{ "I2A50", 27, 30 },
				{ "I2A50", 30, 33 },
				{ "I2A50", 33, 36 },
				{ "I2A186", 36, 39 },
				{ "I2A187", 39, 42 },
				{ "I2A188", 42, 45 },
				{ "I2A189", 45, 48 },
				{ "I2A190", 48, 51 },
				{ "I2A191", 51, 54 },
				{ "I2A192", 54, 57 },
				{ "I2A193", 57, 60 },
				{ "I2A194", 60, 63 },
				{ "I2A195", 63, 66 },
				{ "I2A196", 66, 69 },
				{ "I2A197", 69, 72 },
				{ "I2A198", 72, 75 },
				{ "I2A95", 75, 78 },
				{ "I2A50", 78, 81 },
				{ "I2A50", 81, 84 },
				{ "I2A199", 84, 87 },
				{ "I2A50", 87, 90 },
				{ "I2A50", 90, 93 },
				{ "I2A200", 93, 96 },
				{ "I2A201", 96, 99 },
				{ "I2A202", 99, 102 },
				{ "I2A203", 102, 105 },
				{ "I2A204", 105, 108 },
				{ "I2A204", 108, 111 },
			},
		}

		dashboard.section.header.val = {
			[[ ⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣀⣀⠀⡀⢀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
			[[ ⣶⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⣽⠃⠀⠀⠀⢼⠻⣿⣿⣟⣿⣿⣿⣿⣶⣶⣶⣶⣤⣤⣤⣤⣤ ]],
			[[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠛⡶⢶⢺⠁⠀⠈⢿⣿⣿⣿⣿⣿⣿⣏⣿⣿⣿⣿⣿⣿⣿ ]],
			[[ ⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⣤⠀⣀⣠⡛⣣⡀⠀⠈⢿⣿⣿⣻⣏⣿⣿⣿⣿⣿⣿⣟⣿⠿ ]],
			[[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⣳⣶⣿⣿⣷⣾⠱⠀⠀⠊⢿⠿⠿⢛⣽⣿⡿⢿⣿⣟⠿⠿⠿ ]],
			[[ ⠉⠉⠉⠛⠛⠛⠋⠛⠛⠛⣧⠀⡀⠀⠀⢿⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠅⢀⢀⡀ ]],
			[[ ⠔⠄⢀⡀⠀⠀⠀⠄⠐⠸⠿⡀⠀⠀⠀⢘⣿⢷⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠰⣠⣇ ]],
			[[ ⣷⣆⣴⣮⢻⡲⡲⠀⠁⠀⠀⠀⠀⠀⠀⠹⡿⠘⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣀⡘⢷⣏ ]],
			[[ ⣿⣿⣿⣗⠿⢈⠁⡀⠀⠁⠀⠀⠀⠀⠀⠀⠉⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠠⢀⠄⠀⠄⠈⢿⣮⢿ ]],
			[[ ⣿⣟⡿⣾⠀⠀⠀⠀⠀⠀⠀⢀⡤⠄⠀⠀⠀⠀⠸⠁⢠⣦⣤⢀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠈⣿⠀ ]],
			[[ ⣿⣿⠏⠁⢀⡇⠀⠀⠀⠀⠀⠀⡄⠀⠀⠀⠘⡏⣷⣵⡻⠃⠄⢴⣆⠀⠀⠀⠀⠀⠀⠀⠰⠀⣆⣷⣿ ]],
			[[ ⣿⡿⣻⠗⠀⢠⠀⠀⠀⠀⠀⠃⠀⠀⠀⠀⢠⣤⣄⢰⣶⢯⣤⡈⠋⠀⠀⠀⠀⠀⠀⠀⠀⠆⠀⣿⣼ ]],
		}

		dashboard.section.buttons.val = {
			-- dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("b", "  > Browse files", ":Oil --float<CR>"),
			dashboard.button("z", "  > Browse Directories", ":Telescope zoxide list<CR>"),
			dashboard.button("f", "󰈞  > Find file", ":Telescope find_files<CR>"),
			dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
		}

		alpha.setup(dashboard.opts)
	end,
}
