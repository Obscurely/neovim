return {
	settings = {
		yaml = {
			schemas = {
				["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json"] = {
					"playbooks/*.yml",
					"playbooks/*.yaml",
					"playbook.yml",
					"playbook.yaml",
					"**/ansible/**/*.yml",
					"**/ansible/**/*.yaml",
					"**/playbooks/**/*.yml",
					"**/playbooks/**/*.yaml",
				},
				["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/tasks.json"] = {
					"**/tasks/**/*.yml",
					"**/tasks/**/*.yaml",
				},
			},
			customTags = {
				"!vault",
				"!encrypted/pkcs1-oaep scalar",
				"!vault-encrypted scalar",
			},
			validate = true,
			hover = true,
			completion = true,
			format = { enable = true },
		},
	},
}
