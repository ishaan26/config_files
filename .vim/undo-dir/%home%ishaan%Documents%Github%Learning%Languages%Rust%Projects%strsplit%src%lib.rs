Vim�UnDo� *�}�D���J����y帨��XQ6��B�4   N           4                       a�0    _�                     N        ����                                                                                                                                                                                                                                                                                                                                                             a�    �   M            �   L   N          ;    assert_eq!(letters, vec!["a", "b", "c", "d", "e", ""]);�   K   M          E    let letters: Vec<_> = StrSplit::spliter(haystack, " ").collect();�   J   L               let haystack = "a b c d e ";�   I   K          fn empty_tail() {�   H   J          #[test]�   G   I           �   F   H          }�   E   G          7    assert_eq!(letters, vec!["a", "b", "c", "d", "e"]);�   D   F          E    let letters: Vec<_> = StrSplit::spliter(haystack, " ").collect();�   C   E              let haystack = "a b c d e";�   B   D          fn it_works() {�   A   C          #[test]�   @   B           �   ?   A          }�   >   @          <    assert_eq!(until_character("hello world", 'o'), "hell");�   =   ?          fn until_char_test() {�   <   >          #[test]�   ;   =           �   :   <          }�   9   ;          =        .expect("StrSplit always returns atleast one result")�   8   :                  .next()�   7   9              StrSplit::spliter(s, c)�   6   8          2pub fn until_character(s: &str, c: char) -> &str {�   5   7           �   4   6          }�   3   5              }�   2   4          ?            .map(|(start, _)| (start, start + self.len_utf8()))�   1   3          %            .find(|(_, c)| c == self)�   0   2                  s.char_indices()�   /   1          <    fn find_next(&self, s: &str) -> Option<(usize, usize)> {�   .   0          impl Delimiter for char {�   -   /           �   ,   .          }�   +   -              }�   *   ,          =        s.find(self).map(|start| (start, start + self.len()))�   )   +          <    fn find_next(&self, s: &str) -> Option<(usize, usize)> {�   (   *          impl Delimiter for &str {�   '   )           �   &   (          }�   %   '              }�   $   &          	        }�   #   %          !            self.remainder.take()�   "   $                  } else {�   !   #          !            Some(until_delimiter)�       "          1            *remainder = &remainder[delim_end..];�      !          <            let until_delimiter = &remainder[..delim_start];�                 U        if let Some((delim_start, delim_end)) = self.delimiter.find_next(remainder) {�                1        let remainder = self.remainder.as_mut()?;�                .    fn next(&mut self) -> Option<Self::Item> {�                    type Item = &'haystack str;�                {�                    D: Delimiter,�                where�                6impl<'haystack, D> Iterator for StrSplit<'haystack, D>�                 �                }�                ;    fn find_next(&self, s: &str) -> Option<(usize, usize)>;�                pub trait Delimiter {�                 �                }�                    }�                	        }�                            delimiter: needle,�                &            remainder: Some(haystack),�                        Self {�                A    pub fn spliter(haystack: &'haystack str, needle: D) -> Self {�   
             /    /// Split a string by giving it a delimiter�   	             +impl<'haystack, D> StrSplit<'haystack, D> {�      
           �      	          }�                    delimiter: D,�                &    remainder: Option<&'haystack str>,�                    /// split str!�                #pub struct StrSplit<'haystack, D> {�                #[derive(Debug)]�                 �                 J// #![warn(missing_debug_implementations, rust_2018_idioms, missing_docs)]�   M   N          }5��    M                                           �                J       J           J       J       �                           K                       �                         L                     �               #       #   ]       #       #       �                         �                     �               &       &   �       &       &       �                         �                     �                         �                     �                           �                       �    	           +       +   �       +       +       �    
           /       /   �       /       /       �               A       A   ,      A       A       �                         n                    �               &       &   }      &       &       �                         �                    �               	       	   �      	       	       �                         �                    �                         �                    �                           �                      �                         �                    �               ;       ;   �      ;       ;       �                         (                    �                           *                      �               6       6   +      6       6       �                         b                    �                         h                    �                         z                    �                         |                    �               .       .   �      .       .       �               1       1   �      1       1       �               U       U   �      U       U       �               <       <   S      <       <       �                1       1   �      1       1       �    !           !       !   �      !       !       �    "                     �                    �    #           !       !   �      !       !       �    $           	       	         	       	       �    %                     !                    �    &                     '                    �    '                       )                      �    (                     *                    �    )           <       <   D      <       <       �    *           =       =   �      =       =       �    +                     �                    �    ,                     �                    �    -                       �                      �    .                     �                    �    /           <       <   �      <       <       �    0                                         �    1           %       %   8      %       %       �    2           ?       ?   ^      ?       ?       �    3                     �                    �    4                     �                    �    5                       �                      �    6           2       2   �      2       2       �    7                     �                    �    8                     �                    �    9           =       =         =       =       �    :                     D                    �    ;                       F                      �    <                     G                    �    =                     O                    �    >           <       <   f      <       <       �    ?                     �                    �    @                       �                      �    A                     �                    �    B                     �                    �    C                     �                    �    D           E       E   �      E       E       �    E           7       7   $      7       7       �    F                     \                    �    G                       ^                      �    H                     _                    �    I                     g                    �    J                       y                      �    K           E       E   �      E       E       �    L           ;       ;   �      ;       ;       �    M                                           5�_�                       4    ����                                                                                                                                                                                                                                                                                                                                                             a�/    �   M            �   L   N          ;    assert_eq!(letters, vec!["a", "b", "c", "d", "e", ""]);�   K   M          E    let letters: Vec<_> = StrSplit::spliter(haystack, " ").collect();�   J   L               let haystack = "a b c d e ";�   I   K          fn empty_tail() {�   H   J          #[test]�   G   I           �   F   H          }�   E   G          7    assert_eq!(letters, vec!["a", "b", "c", "d", "e"]);�   D   F          E    let letters: Vec<_> = StrSplit::spliter(haystack, " ").collect();�   C   E              let haystack = "a b c d e";�   B   D          fn it_works() {�   A   C          #[test]�   @   B           �   ?   A          }�   >   @          <    assert_eq!(until_character("hello world", 'o'), "hell");�   =   ?          fn until_char_test() {�   <   >          #[test]�   ;   =           �   :   <          }�   9   ;          =        .expect("StrSplit always returns atleast one result")�   8   :                  .next()�   7   9              StrSplit::spliter(s, c)�   6   8          2pub fn until_character(s: &str, c: char) -> &str {�   5   7           �   4   6          }�   3   5              }�   2   4          ?            .map(|(start, _)| (start, start + self.len_utf8()))�   1   3          %            .find(|(_, c)| c == self)�   0   2                  s.char_indices()�   /   1          <    fn find_next(&self, s: &str) -> Option<(usize, usize)> {�   .   0          impl Delimiter for char {�   -   /           �   ,   .          }�   +   -              }�   *   ,          =        s.find(self).map(|start| (start, start + self.len()))�   )   +          <    fn find_next(&self, s: &str) -> Option<(usize, usize)> {�   (   *          impl Delimiter for &str {�   '   )           �   &   (          }�   %   '              }�   $   &          	        }�   #   %          !            self.remainder.take()�   "   $                  } else {�   !   #          !            Some(until_delimiter)�       "          1            *remainder = &remainder[delim_end..];�      !          <            let until_delimiter = &remainder[..delim_start];�                 U        if let Some((delim_start, delim_end)) = self.delimiter.find_next(remainder) {�                1        let remainder = self.remainder.as_mut()?;�                .    fn next(&mut self) -> Option<Self::Item> {�                    type Item = &'haystack str;�                {�                    D: Delimiter,�                where�                6impl<'haystack, D> Iterator for StrSplit<'haystack, D>�                 �                }�                ;    fn find_next(&self, s: &str) -> Option<(usize, usize)>;�                pub trait Delimiter {�                 �                }�                    }�                	        }�                            delimiter: needle,�                &            remainder: Some(haystack),�                        Self {�                A    pub fn spliter(haystack: &'haystack str, needle: D) -> Self {�   
             /    /// Split a string by giving it a delimiter�   	             +impl<'haystack, D> StrSplit<'haystack, D> {�      
           �      	          }�                    delimiter: D,�                &    remainder: Option<&'haystack str>,�                    /// split str!�                #pub struct StrSplit<'haystack, D> {�                #[derive(Debug)]�                 �                 J// #![warn(missing_debug_implementations, rust_2018_idioms, missing_docs)]�   M   N          }�   M            �   L   N          E    let letters: Vec<_> = StrSplit::spliter(haystack, " ").collect();�   K   M               let haystack = "a b c d e ";�   J   L          fn empty_tail() {�   I   K          #[test]�   H   J           �   G   I          }�   F   H          7    assert_eq!(letters, vec!["a", "b", "c", "d", "e"]);�   E   G          E    let letters: Vec<_> = StrSplit::spliter(haystack, " ").collect();�   D   F              let haystack = "a b c d e";�   C   E          fn it_works() {�   B   D          #[test]�   A   C           �   @   B          }�   ?   A          <    assert_eq!(until_character("hello world", 'o'), "hell");�   >   @          fn until_char_test() {�   =   ?          #[test]�   <   >           �   ;   =          }�   :   <          =        .expect("StrSplit always returns atleast one result")�   9   ;                  .next()�   8   :              StrSplit::spliter(s, c)�   7   9          2pub fn until_character(s: &str, c: char) -> &str {�   6   8           �   5   7          }�   4   6              }�   3   5          ?            .map(|(start, _)| (start, start + self.len_utf8()))�   2   4          %            .find(|(_, c)| c == self)�   1   3                  s.char_indices()�   0   2          <    fn find_next(&self, s: &str) -> Option<(usize, usize)> {�   /   1          impl Delimiter for char {�   .   0           �   -   /          }�   ,   .              }�   +   -          =        s.find(self).map(|start| (start, start + self.len()))�   *   ,          <    fn find_next(&self, s: &str) -> Option<(usize, usize)> {�   )   +          impl Delimiter for &str {�   (   *           �   '   )          }�   &   (              }�   %   '          	        }�   $   &          !            self.remainder.take()�   #   %                  } else {�   "   $          !            Some(until_delimiter)�   !   #          1            *remainder = &remainder[delim_end..];�       "          <            let until_delimiter = &remainder[..delim_start];�      !          -            .delimiter.find_next(remainder) {�                 4        if let Some((delim_start, delim_end)) = self�                1        let remainder = self.remainder.as_mut()?;�                .    fn next(&mut self) -> Option<Self::Item> {�                    type Item = &'haystack str;�                {�                    D: Delimiter,�                where�                6impl<'haystack, D> Iterator for StrSplit<'haystack, D>�                 �                }�                ;    fn find_next(&self, s: &str) -> Option<(usize, usize)>;�                pub trait Delimiter {�                 �                }�                    }�                	        }�                            delimiter: needle,�                &            remainder: Some(haystack),�                        Self {�                A    pub fn spliter(haystack: &'haystack str, needle: D) -> Self {�   
             /    /// Split a string by giving it a delimiter�   	             +impl<'haystack, D> StrSplit<'haystack, D> {�      
           �      	          }�                    delimiter: D,�                &    remainder: Option<&'haystack str>,�                    /// split str!�                #pub struct StrSplit<'haystack, D> {�                #[derive(Debug)]�                 �                 J// #![warn(missing_debug_implementations, rust_2018_idioms, missing_docs)]�   M   N          ;    assert_eq!(letters, vec!["a", "b", "c", "d", "e", ""]);   }�      !   N      U        if let Some((delim_start, delim_end)) = self.delimiter.find_next(remainder) {5��       4                 1              	       �                         2                    �    M                      �      >               �                J       J           J       J       �                           K                       �                         L                     �               #       #   ]       #       #       �                         �                     �               &       &   �       &       &       �                         �                     �                         �                     �                           �                       �    	           +       +   �       +       +       �    
           /       /   �       /       /       �               A       A   ,      A       A       �                         n                    �               &       &   }      &       &       �                         �                    �               	       	   �      	       	       �                         �                    �                         �                    �                           �                      �                         �                    �               ;       ;   �      ;       ;       �                         (                    �                           *                      �               6       6   +      6       6       �                         b                    �                         h                    �                         z                    �                         |                    �               .       .   �      .       .       �               1       1   �      1       1       �               4       U   �      4       U       �               -       <   S      -       <       �                <       1   �      <       1       �    !           1       !   �      1       !       �    "           !          �      !              �    #                  !   �             !       �    $           !       	         !       	       �    %           	          !      	              �    &                     '                    �    '                      )                     �    (                      *                     �    )                  <   D             <       �    *           <       =   �      <       =       �    +           =          �      =              �    ,                     �                    �    -                      �                     �    .                      �                     �    /                  <   �             <       �    0           <                <              �    1                  %   8             %       �    2           %       ?   ^      %       ?       �    3           ?          �      ?              �    4                     �                    �    5                      �                     �    6                   2   �              2       �    7           2          �      2              �    8                     �                    �    9                  =                =       �    :           =          D      =              �    ;                      F                     �    <                      G                     �    =                     O                    �    >                  <   f             <       �    ?           <          �      <              �    @                      �                     �    A                      �                     �    B                     �                    �    C                     �                    �    D                  E   �             E       �    E           E       7   $      E       7       �    F           7          \      7              �    G                      ^                     �    H                      _                     �    I                     g                    �    J                      y                     �    K                   E   �              E       �    L           E       ;   �      E       ;       �    M                                           �    M                                           �                J       J           J       J       �                           K                       �                         L                     �               #       #   ]       #       #       �                         �                     �               &       &   �       &       &       �                         �                     �                         �                     �                           �                       �    	           +       +   �       +       +       �    
           /       /   �       /       /       �               A       A   ,      A       A       �                         n                    �               &       &   }      &       &       �                         �                    �               	       	   �      	       	       �                         �                    �                         �                    �                           �                      �                         �                    �               ;       ;   �      ;       ;       �                         (                    �                           *                      �               6       6   +      6       6       �                         b                    �                         h                    �                         z                    �                         |                    �               .       .   �      .       .       �               1       1   �      1       1       �               U       U   �      U       U       �               <       <   S      <       <       �                1       1   �      1       1       �    !           !       !   �      !       !       �    "                     �                    �    #           !       !   �      !       !       �    $           	       	         	       	       �    %                     !                    �    &                     '                    �    '                       )                      �    (                     *                    �    )           <       <   D      <       <       �    *           =       =   �      =       =       �    +                     �                    �    ,                     �                    �    -                       �                      �    .                     �                    �    /           <       <   �      <       <       �    0                                         �    1           %       %   8      %       %       �    2           ?       ?   ^      ?       ?       �    3                     �                    �    4                     �                    �    5                       �                      �    6           2       2   �      2       2       �    7                     �                    �    8                     �                    �    9           =       =         =       =       �    :                     D                    �    ;                       F                      �    <                     G                    �    =                     O                    �    >           <       <   f      <       <       �    ?                     �                    �    @                       �                      �    A                     �                    �    B                     �                    �    C                     �                    �    D           E       E   �      E       E       �    E           7       7   $      7       7       �    F                     \                    �    G                       ^                      �    H                     _                    �    I                     g                    �    J                       y                      �    K           E       E   �      E       E       �    L           ;       ;   �      ;       ;       �    M                                           5�_�                       4    ����                                                                                                                                                                                                                                                                                                                                                             a�*    �          N      4        if let Some((delim_start, delim_end)) = self   -            .delimiter.find_next(remainder) {�   M   P        �                 J// #![warn(missing_debug_implementations, rust_2018_idioms, missing_docs)]�                 �                #[derive(Debug)]�                #pub struct StrSplit<'haystack, D> {�                    /// split str!�                &    remainder: Option<&'haystack str>,�                    delimiter: D,�      	          }�      
           �   	             +impl<'haystack, D> StrSplit<'haystack, D> {�   
             /    /// Split a string by giving it a delimiter�                A    pub fn spliter(haystack: &'haystack str, needle: D) -> Self {�                        Self {�                &            remainder: Some(haystack),�                            delimiter: needle,�                	        }�                    }�                }�                 �                pub trait Delimiter {�                ;    fn find_next(&self, s: &str) -> Option<(usize, usize)>;�                }�                 �                6impl<'haystack, D> Iterator for StrSplit<'haystack, D>�                where�                    D: Delimiter,�                {�                    type Item = &'haystack str;�                .    fn next(&mut self) -> Option<Self::Item> {�                1        let remainder = self.remainder.as_mut()?;�                 U        if let Some((delim_start, delim_end)) = self.delimiter.find_next(remainder) {�      !          <            let until_delimiter = &remainder[..delim_start];�       "          1            *remainder = &remainder[delim_end..];�   !   #          !            Some(until_delimiter)�   "   $                  } else {�   #   %          !            self.remainder.take()�   $   &          	        }�   %   '              }�   &   (          }�   '   )           �   (   *          impl Delimiter for &str {�   )   +          <    fn find_next(&self, s: &str) -> Option<(usize, usize)> {�   *   ,          =        s.find(self).map(|start| (start, start + self.len()))�   +   -              }�   ,   .          }�   -   /           �   .   0          impl Delimiter for char {�   /   1          <    fn find_next(&self, s: &str) -> Option<(usize, usize)> {�   0   2                  s.char_indices()�   1   3          %            .find(|(_, c)| c == self)�   2   4          ?            .map(|(start, _)| (start, start + self.len_utf8()))�   3   5              }�   4   6          }�   5   7           �   6   8          2pub fn until_character(s: &str, c: char) -> &str {�   7   9              StrSplit::spliter(s, c)�   8   :                  .next()�   9   ;          =        .expect("StrSplit always returns atleast one result")�   :   <          }�   ;   =           �   <   >          #[test]�   =   ?          fn until_char_test() {�   >   @          <    assert_eq!(until_character("hello world", 'o'), "hell");�   ?   A          }�   @   B           �   A   C          #[test]�   B   D          fn it_works() {�   C   E              let haystack = "a b c d e";�   D   F          E    let letters: Vec<_> = StrSplit::spliter(haystack, " ").collect();�   E   G          7    assert_eq!(letters, vec!["a", "b", "c", "d", "e"]);�   F   H          }�   G   I           �   H   J          #[test]�   I   K          fn empty_tail() {�   J   L               let haystack = "a b c d e ";�   K   M          E    let letters: Vec<_> = StrSplit::spliter(haystack, " ").collect();�   L   N          ;    assert_eq!(letters, vec!["a", "b", "c", "d", "e", ""]);�   M   N          }5��       4                 1              	       �                         2                    �    M                      �      >               �                J       J           J       J       �                           K                       �                         L                     �               #       #   ]       #       #       �                         �                     �               &       &   �       &       &       �                         �                     �                         �                     �                           �                       �    	           +       +   �       +       +       �    
           /       /   �       /       /       �               A       A   ,      A       A       �                         n                    �               &       &   }      &       &       �                         �                    �               	       	   �      	       	       �                         �                    �                         �                    �                           �                      �                         �                    �               ;       ;   �      ;       ;       �                         (                    �                           *                      �               6       6   +      6       6       �                         b                    �                         h                    �                         z                    �                         |                    �               .       .   �      .       .       �               1       1   �      1       1       �               4       U   �      4       U       �               -       <   S      -       <       �                <       1   �      <       1       �    !           1       !   �      1       !       �    "           !          �      !              �    #                  !   �             !       �    $           !       	         !       	       �    %           	          !      	              �    &                     '                    �    '                      )                     �    (                      *                     �    )                  <   D             <       �    *           <       =   �      <       =       �    +           =          �      =              �    ,                     �                    �    -                      �                     �    .                      �                     �    /                  <   �             <       �    0           <                <              �    1                  %   8             %       �    2           %       ?   ^      %       ?       �    3           ?          �      ?              �    4                     �                    �    5                      �                     �    6                   2   �              2       �    7           2          �      2              �    8                     �                    �    9                  =                =       �    :           =          D      =              �    ;                      F                     �    <                      G                     �    =                     O                    �    >                  <   f             <       �    ?           <          �      <              �    @                      �                     �    A                      �                     �    B                     �                    �    C                     �                    �    D                  E   �             E       �    E           E       7   $      E       7       �    F           7          \      7              �    G                      ^                     �    H                      _                     �    I                     g                    �    J                      y                     �    K                   E   �              E       �    L           E       ;   �      E       ;       �    M                                           5��