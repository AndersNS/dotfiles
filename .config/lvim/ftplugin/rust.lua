lvim.builtin.which_key.mappings["r"] = {
	name = "Rust",
	h = { "<cmd>RustToggleInlayHints<CR>", "ToggleHints" },
	r = { "<cmd>RustRunnables<CR>", "Runnables" },
	d = { "<cmd>RustDebuggables<CR>", "Debuggables" },
	g = { "<cmd>RustViewCrateGraph<CR>", "Create Graph" },
	a = { "<cmd>RustHoverActions<CR>", "Actions" },
}

-- RustSetInlayHints
-- RustDisableInlayHints
-- RustToggleInlayHints
-- RustRunnables
-- RustExpandMacro
-- RustOpenCargo
-- RustParentModule
-- RustJoinLines
-- RustHoverActions
-- RustHoverRange
-- RustMoveItemDown
-- RustMoveItemUp
-- RustStartStandaloneServerForBuffer
-- RustDebuggables
-- RustViewCrateGraph
-- RustReloadWorkspace
-- RustSSR