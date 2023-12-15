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
{ gis'16 fis'4 a'4 b'4 cis''2. e''4 fis''8 gis''8 fis''8 e''8 cis''8 b'2. cis''8 b'8 b'4 cis''2. e''4 cis''4 cis''4 cis''4 b'4 cis''4 e''8 cis''8 b'8 b'8 cis''8 b'8 cis''4 d''4 cis''4 e''8 fis''8 e''8 cis''8 cis''8 b'2. cis''8 cis''8 b'8 a'4 gis'4 a'4 b'4 cis''2. e''4 cis''4 cis''2. b'8 cis''4 cis''4 cis''8 gis''8 fis''8 cis''8 b'2. cis''8 cis''4 e''4 cis''4 cis''8 b'8 cis''4 b'4 cis''4 b'16 a'16 gis'16 b'16 cis''4 cis''4 cis''16 d''16 cis''4 b'4 cis''4 b'16 cis''4 b'16 cis''4 cis''8 cis''4 cis''2. e''4 cis''4 cis''8 b'2. cis''8 cis''8 b'2. cis''8 b'2. cis''8 cis''4 e''4 fis''8 e''8 fis''8 cis''8 b'8 cis''4 cis''16 b'4 a'4 gis'4 fis'16 fis'4 fis'4 a'4 gis'16 fis'4 a'4 e'4 fis'4 gis'2. a'4 fis'4 e'4 fis'4 fis'4 fis'16 fis'16 fis'4 e'4 fis'4 gis'2. a'4 gis'16 a'16 gis'16 b'16 a'16 fis'16 cis'16 e'16 gis'4 a'4 gis'4 fis'16 fis'16 fis'4 fis'4 fis'8 e'8 fis'2. fis'8 e'4 e'2. fis'8 e'16 gis'16 b'16 a'16 gis'16 b'16 cis''16 b'4 cis''8 cis''8 b'2. cis''8 cis''8 cis''8 b'8 cis''4 d''4 cis''4 b'4 cis''2. e''4 fis''8 e''8 fis''4 fis''8 e''8 fis''4 fis''8 cis''8 b'8 a'8 b'4 cis''4 b'4 cis''4 e''4 gis''8 a''8 gis''8 fis''8 e''8 gis''8 e''8 gis''8 b''8 a''8 b''8 a''8 gis''8 fis''8 cis''8 cis''8 b'8 cis''4 b'4 cis''2. e''4 fis''8 cis''8 b'8 b'8 b'4 a'4 b'4 cis''2. b'8 a'8 b'4 a'4 e'4 fis'2. fis'8 e'4 fis'4 fis'4 e'2. a'8 e'4 fis'4 e'2. a'8 e'4 fis'4 e'4 fis'4 e'16 fis'16 fis'4 fis'4 a'2. b'4 b'8 b'4 a'4 a'4 a'4 a'4 b'4 a'4 b'4 cis''2. e''4 fis''8 e''8 fis''8 cis''8 b'8 } \\ 
  } % Staff


  \layout {
    \context { \RemoveEmptyStaffContext }
  }
  \midi { }
} % score