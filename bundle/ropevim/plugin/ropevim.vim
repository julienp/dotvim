function! LoadRope()
python << EOF
import ropevim
EOF
endfunction

if ('has_gui')
call LoadRope()
endif
