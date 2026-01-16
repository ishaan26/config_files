{
  programs.nvf.settings.vim.keymaps = [
    # Toggle between current and last file
    {
      key = "<leader><leader>";
      mode = "n";
      action = "<cmd>e #<cr>";
      desc = "Switch to last buffer";
    }

    # Exit insert mode with jk
    {
      key = "jk";
      mode = "i";
      action = "<esc>";
      desc = "Exit insert mode";
    }

    # File tree toggle
    {
      key = "<leader>e";
      mode = "n";
      action = "<cmd>Neotree toggle<cr>";
      desc = "Toggle file tree";
    }

    # Telescope
    {
      key = "<leader>ff";
      mode = "n";
      action = "<cmd>Telescope find_files<cr>";
      desc = "Find files";
    }
    {
      key = "<leader>fg";
      mode = "n";
      action = "<cmd>Telescope live_grep<cr>";
      desc = "Live grep";
    }
    {
      key = "<leader>fb";
      mode = "n";
      action = "<cmd>Telescope buffers<cr>";
      desc = "Find buffers";
    }
    {
      key = "<leader>fh";
      mode = "n";
      action = "<cmd>Telescope help_tags<cr>";
      desc = "Help tags";
    }
    {
      key = "<leader>fo";
      mode = "n";
      action = "<cmd>Telescope oldfiles<cr>";
      desc = "Find recently opened files";
    }

    # Window navigation
    {
      key = "<C-h>";
      mode = "n";
      action = "<C-w>h";
      desc = "Move to left window";
    }
    {
      key = "<C-j>";
      mode = "n";
      action = "<C-w>j";
      desc = "Move to bottom window";
    }
    {
      key = "<C-k>";
      mode = "n";
      action = "<C-w>k";
      desc = "Move to top window";
    }
    {
      key = "<C-l>";
      mode = "n";
      action = "<C-w>l";
      desc = "Move to right window";
    }

    # Buffer navigation
    {
      key = "<S-h>";
      mode = "n";
      action = "<cmd>bprevious<cr>";
      desc = "Previous buffer";
    }
    {
      key = "<S-l>";
      mode = "n";
      action = "<cmd>bnext<cr>";
      desc = "Next buffer";
    }
    {
      key = "<leader>bd";
      mode = "n";
      action = "<cmd>bdelete<cr>";
      desc = "Delete buffer";
    }

    # Save file
    {
      key = "<leader>w";
      mode = "n";
      action = "<cmd>w<cr>";
      desc = "Save file";
    }

    # Quit
    {
      key = "<leader>q";
      mode = "n";
      action = "<cmd>q<cr>";
      desc = "Quit";
    }

    # Clear search highlights
    {
      key = "<leader>h";
      mode = "n";
      action = "<cmd>nohlsearch<cr>";
      desc = "Clear search highlights";
    }

    # Better indenting (stay in visual mode)
    {
      key = "<";
      mode = "v";
      action = "<gv";
      desc = "Indent left";
    }
    {
      key = ">";
      mode = "v";
      action = ">gv";
      desc = "Indent right";
    }

    # Move lines up/down in visual mode
    {
      key = "J";
      mode = "v";
      action = ":m '>+1<cr>gv=gv";
      desc = "Move line down";
    }
    {
      key = "K";
      mode = "v";
      action = ":m '<-2<cr>gv=gv";
      desc = "Move line up";
    }
  ];
}
