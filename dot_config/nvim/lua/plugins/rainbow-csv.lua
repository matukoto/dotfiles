-- dot_config/nvim/lua/plugins/rainbow-csv.lua
return {
  'mechatroner/rainbow_csv',
  -- Load specifically for csv and tsv files
  ft = { "csv", "tsv", "txt" }, -- Add other delimiters if needed, e.g., "psv" for pipe
  -- init function runs before the plugin is loaded, suitable for setting globals
  init = function()
    -- Define the color pairs for columns
    vim.g.rcsv_colorpairs = {
      { 'red', 'red' },
      { 'yellow', 'yellow' },
      { 'lightgray', 'lightgray' },
      { 'lightgreen', 'lightgreen' },
      { 'lightblue', 'lightblue' },
      { 'cyan', 'cyan' },
      { 'lightred', 'lightred' },
      { 'darkyellow', 'darkyellow' },
      { 'white', 'white' },
      -- Add more pairs if needed
    }
    -- Optional: Define other rainbow_csv global settings here if necessary
    -- vim.g.rcsv_delimiters = { ',', ';', '\t', '|' } -- Example: Add more delimiters
  end,
  -- No explicit opts or config needed as configuration is done via globals
}
