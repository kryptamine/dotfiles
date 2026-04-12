return {
	"mistweaverco/kulala.nvim",
	keys = {
		{
			"<leader>rs",
			function()
				require("kulala").run()
			end,
			desc = "Send the request",
		},
		{
			"<leader>rk",
			function()
				require("kulala").scratchpad()
			end,
			desc = "Kulala Scratchpad",
		},
	},
	opts = {
		ui = {
			default_winbar_panes = { "body", "headers", "verbose", "report" },
			show_request_summary = false,
			scratchpad_default_contents = {
				"@token=token",
				"",
				"GET https://platform360.staging.plesk.tech/api/accounts/me HTTP/1.1",
				"accept: application/json",
				"content-type: application/json",
				"authorization: Bearer {{token}}",
			},
		},
	},
}
