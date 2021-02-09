{ config, pkgs, ... }:

{
  programs.neovim = let
    myVimPlugins = let
      detectindent = pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "detectindent";
        version = "2015-3-9";
        src = pkgs.fetchFromGitHub {
          owner = "ciaranm";
          repo = "detectindent";
          rev = "c09ab6effc29ef913c531816eb980460f8dc9ed2";
          sha256 = "035mnx8i002v7al3k89cmv3f9p38l42ix1v3hhxirqnx445iv2p2";
        };
      };
      vim-easyescape = pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "vim-easyescape";
        version = "2018-7-1";
        src = pkgs.fetchFromGitHub {
          owner = "zhou13";
          repo = "vim-easyescape";
          rev = "7054da8cae2995fb5f834790d3a6c8c880aabc7d";
          sha256 = "1qblymwdgnv11q4cpw3sz8pl1zv765rwq5rskk5sapjz6bc8vc0p";
        };
      };
      browserlink-vim = pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "browserlink-vim";
        version = "2019-11-30";
        src = pkgs.fetchFromGitHub {
          owner = "jaxbot";
          repo = "browserlink.vim";
          rev = "5882029a4f3528a39024f120dbb24ca9a6495dcb";
          sha256 = "1xl3ccb1fs68l264y0sbax9iwnv6fh092afckwi8z9vm97115ibn";
        };     
      };
      in with pkgs.vimPlugins; [
        browserlink-vim
        nerdcommenter
        coc-nvim
        gruvbox
        vim-airline
        vim-airline-themes
        detectindent
        vim-easyescape
        vim-toml
        vim-pencil
        vim-nix
      ];
    myCocExtensions = [
      "coc-python"
      "coc-java"
      "coc-lists"
      "coc-highlight"
      "coc-json"
      "coc-git"
      "coc-prettier"
      # "coc-markdownlint"
      "coc-tsserver"
      "coc-tslint"
      "coc-rls"
    ];
  in {
    enable = true;
    extraPython3Packages = (ps: with ps; [
      rope
      jedi
      pylint
      pynvim
      pip
    ]);
    withPython = true;
    withPython3 = true;
    withNodeJs = true;
    viAlias = true;
    vimAlias = true;   
    configure = {
      customRC = ''
        filetype off
  
        " Find tags file in previous directories
        set tags=tags;/
        
        " Formatting
        " filetype plugin indent on
        " Use tabs and show it as 4 spaces
        " DetectIndent on Startup
        set shiftwidth=4 expandtab softtabstop=4       
        autocmd bufenter * :DetectIndent

        " Easy Escape
        let g:easyescape_chars = { "j": 1, "k": 1 }
        let g:easyescape_timeout = 100
        cnoremap jk <ESC>
        cnoremap kj <ESC>
        " let g:easyescape_chars = { "j": 2 }
        " let g:easyescape_timeout = 200
        " cnoremap jj <ESC>

        " Thesaurus Keybinding
        let g:tq_map_keys=0
        nnoremap <Leader>t :ThesaurusQueryReplaceCurrentWord<CR>
        
        " Keybindings
        let mapleader=" "
        set backspace=indent,eol,start
        " inoremap <esc> <nop>
        nnoremap <leader>wp viw<esc>a)<esc>bhr(
        " Use tab for trigger completion with characters ahead and navigate.
        " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
        
        " use <tab> for trigger completion and navigate to the next complete item
        function! s:check_back_space() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~ '\s'
        endfunction
        
        inoremap <silent><expr> <Tab>
          \ pumvisible() ? "\<C-n>" :
              \ <SID>check_back_space() ? "\<Tab>" :
              \ coc#refresh()
  
        " Remap for rename current word
        nmap <leader>rn <Plug>(coc-rename)
        
        " Remap for format selected region
        xmap <leader>f  <Plug>(coc-format-selected)
        nmap <leader>f  <Plug>(coc-format-selected)
        
        augroup mygroup
          autocmd!
          " Setup formatexpr specified filetype(s).
          autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
          " Update signature help on jump placeholder
          autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        augroup end
        
        " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
        xmap <leader>a  <Plug>(coc-codeaction-selected)
        nmap <leader>a  <Plug>(coc-codeaction-selected)
        
        " Use `[g` and `]g` to navigate diagnostics
        nmap <silent> [g <Plug>(coc-diagnostic-prev)
        nmap <silent> ]g <Plug>(coc-diagnostic-next)
        
        " Remap keys for gotos
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)
        
        " Remap for do codeAction of current line
        nmap <leader>ac  <Plug>(coc-codeaction)
        " Fix autofix problem of current line
        nmap <leader>qf  <Plug>(coc-fix-current)
        
        " Use `:Format` to format current buffer
        command! -nargs=0 Format :call CocAction('format')
        
        " Use `:Fold` to fold current buffer
        command! -nargs=? Fold :call     CocAction('fold', <f-args>)
        
        " Using CocList
        " Show all diagnostics
        nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
        " Manage extensions
        nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
        " Show commands
        nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
        " Find symbol of current document
        nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
        " Search workspace symbols
        nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
        " Do default action for next item.
        nnoremap <silent> <space>j  :<C-u>CocNext<CR>
        " Do default action for previous item.
        nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
        " Resume latest coc list
        nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
        
        " NERDTree Settings
        " autocmd vimenter * NERDTree
        " focus window other than nerdtree
        " autocmd VimEnter * wincmd p
        " close if nerdtree is only buffer
        " autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
        " map <C-n> :NERDTreeToggle<CR>
        
        " NERD Commenter settings
        " Add spaces after comment delimiters by default
        let g:NERDSpaceDelims = 1
          
        " Theming
        colorscheme gruvbox
        syntax on
        set background=dark    " Setting dark mode
        let g:airline_powerline_fonts = 1
  
        " Installing Coc Extensions
        let g:coc_global_extensions = [ ${pkgs.lib.concatStringsSep "," (map (x: "\""+x+"\"") myCocExtensions)} ]
      '';
  
      # Installing vim plugins from myVimPlugins
      plug.plugins = myVimPlugins;
    };
  };
}
