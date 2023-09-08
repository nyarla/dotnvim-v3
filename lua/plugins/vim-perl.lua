return {
  "vim-perl/vim-perl",
  lazy = false,
  build = "make clean carp dancer highlight-all-pragmas moose test-more try-tiny object-pad"
}
