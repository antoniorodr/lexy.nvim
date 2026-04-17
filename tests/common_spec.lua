---@module "luassert"

local common = require("lexy.common")

describe("common lexy files", function()
	it("should return the correct path to the lexy files", function()
		local expected_path = "/Users/antonio/.config/lexy/files/"
		assert.equals(expected_path, common.data_folder())
	end)
end)

describe("common file info", function()
	it("should return the correct name and extension for a file with an extension", function()
		local name, extension = common.file_info("example.txt")
		assert.equals("example", name)
		assert.equals("txt", extension)
	end)

	it("should return the correct name and nil for a file without an extension", function()
		local name, extension = common.file_info("example")
		assert.equals("example", name)
		assert.is_nil(extension)
	end)
end)

describe("common get data dirs", function()
	it("should return the default data directory when no options are provided", function()
		local dirs = common.get_data_dirs()
		assert.equals(1, #dirs)
		assert.equals("/Users/antonio/.config/lexy/files/", dirs[1])
	end)

	it("should return an empty table if restrict_sources contains non-existent directories", function()
		local opts = { restrict_sources = { "nonexistent" } }
		local dirs = common.get_data_dirs(opts)
		assert.equals(0, #dirs)
	end)
end)

describe("common find docs", function()
	it("should notify the user if no documentation is found for the query", function()
		local query = "nonexistent"
		local notify_called = false
		local original_notify = vim.notify

		vim.notify = function(message, level)
			assert.equals("No documentation found for query: " .. query, message)
			assert.equals(vim.log.levels.WARN, level)
			notify_called = true
		end

		common.find_docs(query)
		assert.is_true(notify_called)

		vim.notify = original_notify
	end)
end)

describe("common lexy update", function()
	it("should update the lexy files without errors", function()
		assert.has_no.errors(function()
			common.update_data()
		end)
	end)
end)
