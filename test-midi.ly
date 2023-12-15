\version "2.18.2"

\header {
  title = "Something good"
  composer = "Composer"
}

\score
{
  \new Staff
  {
    \tempo 4=120
    \key c \major
    \clef treble
{ d'2 f'1 c'2 d'2 f'1 g'2 f'2 f'2 c'1 d'1 f'4 f'2 c'1 d'1 f'4 f'2 a'2 g'1 g'2 c''1 a'2 g'2 c''1 a'2 a'2 g'2 c''1 c''2 c'1 d'1 f'4 f'2 d'2 f'1 g'2 a'2 g'2 a'2 g'2 f'2 f'2 g'2 g'4 a'1 c''2 d''2 c''2 d''2 e''2 f''2 a'2 a'2 d''2 c''2 c''4 c''1 a'2 g'2 g'4 a'1 g'2 f'2 d'2 f'1 f'2 d'2 f'1 c'2 d'2 f'1 f'2 a'2 d''2 c''2 c'1 d'1 f'4 d'2 f'1 f'2 g'2 g'4 f'2 f'2 c''1 c'2 d'2 f'1 g'2 f'2 c''2 c'1 d'1 f'4 d'2 f'1 f'2 f'2 g'4 a'1 g'2 f'1 c'2 d'2 f'1 f'2 g'4 a'1 g'2 a'1 c''2 d''2 e''2 f''2 a'2 g'2 a'1 g'2 g'4 a'1 c''2 c'1 d'1 f'4 d'2 f'1 f'2 g'4 a'1 ais'0 g'2 a'1 ais'0 g'2 g'4 a'1 g'2 g'4 a'1 g'2 f'2 g'4 a'1 g'2 a'1 c''2 c'1 d'1 f'4 f'2 f'2 f'4 f'2 f'2 f'4 d'2 f'1 f'2 d'2 f'1 f'2 f'4 f'2 a'2 g'2 g'4 f'2 f'2 f'2 e'1 g'2 c''1 a'2 g'2 c''1 c'2 d'2 f'1 f'2 f'2 d'2 f'2 c'1 d'1 f'4 d'2 f'1 f'2 g'4 f'2 g'2 c''1 a'2 g'1 g'2 c''1 a'2 g'1 f'2 a'2 g'2 f'2 g'1 g'2 g'4 f'2 g'1 g'2 g'4 f'2 c''2 c''4 c''1 c''2 d''2 c''2 d''2 c''2 c''4 c''1 a'2 d''2 e''2 f''2 a'2 g'2 f'2 g'2 a'1 ais'0 g'2 f'2 g'1 g'2 a'2 g'2 f'1 f'2 g'2 g'4 f'2 f'2 f'2 g'1 f'2 a'2 g'2 a'1 c''2 c'1 d'1 f'4 f'2 g'1 g'2 f'1 } \\ 
  } % Staff


  \layout {
    \context { \RemoveEmptyStaffContext }
  }
  \midi { }
} % score