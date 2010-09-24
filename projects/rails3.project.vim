runtime! projects/rails.project.vim

augroup project
  autocmd!

  autocmd Filetype rspec.ruby RunCommand !bin/rspec % --format=documentation
  autocmd BufEnter Gemfile RunCommand !bundle install
augroup END

set tags+=~/tags/rails30.tags
