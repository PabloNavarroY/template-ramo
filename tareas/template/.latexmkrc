@default_files = ('main.tex');
ensure_path( 'TEXINPUTS', '../', '../../latex-stash//' );

$pdf_previewer = "start zathura %O %S";

# Outputs
$pdf_mode = 1;
$postscript_mode = 0;
$dvi_mode = 0;

# Auxiliary files
$clean_ext = "lox";
