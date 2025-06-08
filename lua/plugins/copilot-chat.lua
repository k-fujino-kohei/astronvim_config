if true then return {} end

---@type LazySpec
return {
  "CopilotC-Nvim/CopilotChat.nvim",
  version = "^3",
  cmd = {
    "CopilotChat",
    "CopilotChatOpen",
    "CopilotChatClose",
    "CopilotChatToggle",
    "CopilotChatStop",
    "CopilotChatReset",
    "CopilotChatSave",
    "CopilotChatLoad",
    "CopilotChatDebugInfo",
    "CopilotChatModels",
    "CopilotChatAgents",
    "CopilotChatExplain",
    "CopilotChatReview",
    "CopilotChatFix",
    "CopilotChatOptimize",
    "CopilotChatDocs",
    "CopilotChatFixTests",
    "CopilotChatCommit",
  },
  dependencies = {
    { "zbirenbaum/copilot.lua" },
    { "nvim-lua/plenary.nvim" },
    {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        local maps = assert(opts.mappings)
        local prefix = opts.options.g.copilot_chat_prefix or "<Leader>P"
        local astroui = require "astroui"

        maps.n[prefix] = { desc = astroui.get_icon("CopilotChat", 1, true) .. "CopilotChat" }
        maps.v[prefix] = { desc = astroui.get_icon("CopilotChat", 1, true) .. "CopilotChat" }

        maps.n[prefix .. "o"] = { ":CopilotChatOpen<CR>", desc = "Open Chat" }
        maps.n[prefix .. "c"] = { ":CopilotChatClose<CR>", desc = "Close Chat" }
        maps.n[prefix .. "t"] = { ":CopilotChatToggle<CR>", desc = "Toggle Chat" }
        maps.n[prefix .. "r"] = { ":CopilotChatReset<CR>", desc = "Reset Chat" }
        maps.n[prefix .. "s"] = { ":CopilotChatStop<CR>", desc = "Stop Chat" }

        maps.n[prefix .. "S"] = {
          function()
            vim.ui.input({ prompt = "Save Chat: " }, function(input)
              if input ~= nil and input ~= "" then require("CopilotChat").save(input) end
            end)
          end,
          desc = "Save Chat",
        }

        maps.n[prefix .. "L"] = {
          function()
            local copilot_chat = require "CopilotChat"
            local path = copilot_chat.config.history_path
            local chats = require("plenary.scandir").scan_dir(path, { depth = 1, hidden = true })
            -- Remove the path from the chat names and .json
            for i, chat in ipairs(chats) do
              chats[i] = chat:sub(#path + 2, -6)
            end
            vim.ui.select(chats, { prompt = "Load Chat: " }, function(selected)
              if selected ~= nil and selected ~= "" then copilot_chat.load(selected) end
            end)
          end,
          desc = "Load Chat",
        }

        local function select_action(selection_type)
          return function()
            require("CopilotChat").select_prompt { selection = require("CopilotChat.select")[selection_type] }
          end
        end

        maps.n[prefix .. "p"] = {
          select_action "buffer",
          desc = "Prompt actions",
        }

        maps.v[prefix .. "p"] = {
          select_action "visual",
          desc = "Prompt actions",
        }

        local function quick_chat(selection_type)
          return function()
            vim.ui.input({ prompt = "Quick Chat: " }, function(input)
              if input ~= nil and input ~= "" then
                require("CopilotChat").ask(input, { selection = require("CopilotChat.select")[selection_type] })
              end
            end)
          end
        end

        maps.n[prefix .. "q"] = {
          quick_chat "buffer",
          desc = "Quick Chat",
        }

        maps.v[prefix .. "q"] = {
          quick_chat "visual",
          desc = "Quick Chat",
        }
      end,
    },
    { "AstroNvim/astroui", opts = { icons = { CopilotChat = "" } } },
  },
  opts = {
    show_help = "yes",
    prompts = {
      Explain = {
        prompt = "/COPILOT_EXPLAIN コードを日本語で説明してください",
        mapping = "<leader>ce",
        description = "コードの説明をお願いする",
      },
      Review = {
        prompt = "/COPILOT_REVIEW コードを日本語でレビューしてください。",
        mapping = "<leader>cr",
        description = "コードのレビューをお願いする",
      },
      Fix = {
        prompt = "/COPILOT_FIX このコードには問題があります。バグを修正したコードを表示してください。説明は日本語でお願いします。",
        mapping = "<leader>cf",
        description = "コードの修正をお願いする",
      },
      Optimize = {
        prompt = "/COPILOT_REFACTOR 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。説明は日本語でお願いします。",
        mapping = "<leader>co",
        description = "コードの最適化をお願いする",
      },
      Docs = {
        prompt = "/COPILOT_GENERATE 選択したコードに関するドキュメントコメントを日本語で生成してください。",
        mapping = "<leader>cd",
        description = "コードのドキュメント作成をお願いする",
      },
      Tests = {
        prompt = "/COPILOT_TESTS 選択したコードの詳細なユニットテストを書いてください。説明は日本語でお願いします。",
        mapping = "<leader>ct",
        description = "テストコード作成をお願いする",
      },
      FixDiagnostic = {
        prompt = "コードの診断結果に従って問題を修正してください。修正内容の説明は日本語でお願いします。",
        mapping = "<leader>cd",
        description = "コードの修正をお願いする",
        selection = require("CopilotChat.select").diagnostics,
      },
      Commit = {
        prompt = "実装差分に対するコミットメッセージを日本語で記述してください。",
        mapping = "<leader>cco",
        description = "コミットメッセージの作成をお願いする",
        selection = require("CopilotChat.select").gitdiff,
      },
      CommitStaged = {
        prompt = "ステージ済みの変更に対するコミットメッセージを日本語で記述してください。",
        mapping = "<leader>cs",
        description = "ステージ済みのコミットメッセージの作成をお願いする",
        selection = function(source) return require("CopilotChat.select").gitdiff(source, true) end,
      },
    },
  },
}
