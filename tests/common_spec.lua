---@module "luassert"

local common = require("lexy.common")

describe("common lexy files", function()
	it("should return the correct path to the lexy files", function()
		local home = vim.loop.os_homedir()
		local expected_path = home .. "/.config/lexy/files/"
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
		local home = vim.loop.os_homedir()
		local dirs = common.get_data_dirs()
		assert.equals(1, #dirs)
		assert.equals(home .. "/.config/lexy/files/", dirs[1])
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
	it("should call lexy update and notify on success", function()
		local system_called = false
		local notifications = {}
		local original_notify = vim.notify
		local original_system = vim.system

		finally(function()
			vim.notify = original_notify
			vim.system = original_system
		end)

		vim.notify = function(message, level)
			table.insert(notifications, { message = message, level = level })
		end

		vim.system = function(cmd, opts, callback)
			system_called = true
			assert.same({ "lexy", "update" }, cmd)
			assert.same({ text = true }, opts)
			callback({ code = 0, stderr = "" })
		end

		common.update_data()

		vim.wait(100, function()
			return #notifications > 0
		end)

		assert.is_true(system_called)
		assert.equals(1, #notifications)
		assert.equals("Lexy updated successfully", notifications[1].message)
		assert.equals(vim.log.levels.INFO, notifications[1].level)
	end)
end)
