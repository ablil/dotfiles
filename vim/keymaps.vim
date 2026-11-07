let mapleader = ','

if has('ide')
  set surround
  set ideajoin
  set nerdtree
  set easymotion
  set which-key
  set notimeout

  " jump around
  map T <Action>(RunClass)
  nmap [[ <Action>(MethodUp)
  nmap ]] <Action>(MethodDown)
  nmap ]e <Action>(GotoNextError)
  nmap [e <Action>(GotoPreviousError)

  " refactoring
  map <leader>rn <Action>(RenameElement)
  map <leader>rm <Action>(ExtractMethod)
  map <leader>rv <Action>(IntroduceVariable)
  map <leader>rf <Action>(IntroduceField)
  map <leader>rs <Action>(ChangeSignature)
  map <leader>rr <Action>(Refactorings.QuickListPopupAction)

  " goto
  map <leader>t <Action>(GotoTest)
  map <leader>n <Action>(GotoClass)
  map <leader>f <Action>(GotoFile)
  map <leader>a <Action>(GotoAction)
  map <leader>x <Action>(GotoSymbol)
  map <leader>e <Action>(RecentFiles)

  " misc
  map <leader>s <Action>(FileStructurePopup)
  map <leader>o <Action>(ActivateTerminalToolWindow)

  " debug
  nmap <leader>dx <Action>(Debug)
  nmap <leader>db <Action>(ToggleLineBreakpoint)
endif
