Vim�UnDo� �f��b��]��[ƙ�Y�!��P�f��&P;��   e                                  b�)    _�                            ����                                                                                                                                                                                                                                                                                                                                                             b�    �   d            �   c   e              }�   b   d          6        assert_eq!(x, [0.12, 2.34352, 2.231231, 2.3]);�   a   c          #        assert_eq!(e.lowest, 0.12);�   `   b          (        assert_eq!(e.greatest, 2.34352);�   _   a           �   ^   `          '        let e = ExtremaNoRefs::new(&x);�   ]   _          /        let x = [0.12, 2.34352, 2.231231, 2.3];�   \   ^               fn extrema_no_refs_works() {�   [   ]              #[test]�   Z   \           �   Y   [              }�   X   Z          /        assert_eq!(x, [12, 23, -221, -2, 123]);�   W   Y          $        assert_eq!(*e.lowest, -221);�   V   X          %        assert_eq!(*e.greatest, 123);�   U   W           �   T   V          !        let e = Extrema::new(&x);�   S   U          ,        let x = vec![12, 23, -221, -2, 123];�   R   T              fn extrema_works() {�   Q   S              #[test]�   P   R           �   O   Q              use super::*;�   N   P          mod tests {�   M   O          #[cfg(test)]�   L   N           �   K   M          }�   J   L              }�   I   K          !        Self { greatest, lowest }�   H   J          	        }�   G   I                      }�   F   H                          lowest = *i;�   E   G                      if i < &lowest {�   D   F                      }�   C   E                          greatest = *i;�   B   D                      if i > &greatest {�   A   C          '        for i in slice.iter().skip(1) {�   @   B           �   ?   A          "        let mut lowest = slice[0];�   >   @          $        let mut greatest = slice[0];�   =   ?          %    pub fn new(slice: &[V]) -> Self {�   <   >           �   ;   =              /// ```�   :   <          #    /// assert_eq!(e.lowest, 0.12);�   9   ;          (    /// assert_eq!(e.greatest, 2.34352);�   8   :              ///�   7   9          '    /// let e = ExtremaNoRefs::new(&x);�   6   8          /    /// let x = [0.12, 2.34352, 2.231231, 2.3];�   5   7              ///�   4   6          0    /// use implementor::extrema::ExtremaNoRefs;�   3   5              /// ```�   2   4              /// # Example�   1   3          ?    /// This copies the values meaning this is not so effecient�   0   2          7    /// Get the greatest and lowest values in an array.�   /   1          {�   .   0          #    V: std::cmp::PartialOrd + Copy,�   -   /          where�   ,   .          impl<V> ExtremaNoRefs<V>�   +   -           �   *   ,          }�   )   +              pub lowest: V,�   (   *              pub greatest: V,�   '   )          pub struct ExtremaNoRefs<V> {�   &   (          #[derive(PartialEq, Debug)]�   %   '           �   $   &          }�   #   %              }�   "   $          !        Self { greatest, lowest }�   !   #          	        }�       "                      }�      !                          lowest = i;�                             if i < lowest {�                            }�                                greatest = i;�                            if i > greatest {�                '        for i in slice.iter().skip(1) {�                 �                #        let mut lowest = &slice[0];�                %        let mut greatest = &slice[0];�                (    pub fn new(slice: &'a [T]) -> Self {�                 �                    /// ```�                $    /// assert_eq!(*e.lowest, -221);�                %    /// assert_eq!(*e.greatest, 123);�                    ///�                !    /// let e = Extrema::new(&x);�                (    /// let x = [12, 23, -221, -2, 123];�                    ///�                1    /// use implementor::basic::extrema::Extrema;�                    /// ```�                    /// # Example�   
             6    /// Get the greatest and lowest values in an array�   	             {�      
              T: std::cmp::PartialOrd,�      	          where�                impl<'a, T> Extrema<'a, T>�                 �                }�                    pub lowest: &'a T,�                    pub greatest: &'a T,�                pub struct Extrema<'a, T> {�                 #[derive(PartialEq, Debug)]�   d   e          }�         e      *    /// use implementor::extrema::Extrema;5��                                              �                                            �                                            �    d                      	                     �                                                �                                              �                         8                     �                         Q                     �                         h                     �                           j                       �                         k                     �                         �                     �                         �                     �    	                     �                     �    
           6       6   �       6       6       �                         �                     �                         �                     �               1       1          1       1       �                         2                    �               (       (   :      (       (       �               !       !   c      !       !       �                         �                    �               %       %   �      %       %       �               $       $   �      $       $       �                         �                    �                           �                      �               (       (   �      (       (       �               %       %         %       %       �               #       #   4      #       #       �                           X                      �               '       '   Y      '       '       �                         �                    �                         �                    �                         �                    �                         �                    �                         �                    �                                              �    !           	       	         	       	       �    "           !       !         !       !       �    #                     =                    �    $                     C                    �    %                       E                      �    &                     F                    �    '                     b                    �    (                     �                    �    )                     �                    �    *                     �                    �    +                       �                      �    ,                     �                    �    -                     �                    �    .           #       #   �      #       #       �    /                     �                    �    0           7       7   �      7       7       �    1           ?       ?   (      ?       ?       �    2                     h                    �    3                     z                    �    4           0       0   �      0       0       �    5                     �                    �    6           /       /   �      /       /       �    7           '       '   �      '       '       �    8                                         �    9           (       (         (       (       �    :           #       #   H      #       #       �    ;                     l                    �    <                       x                      �    =           %       %   y      %       %       �    >           $       $   �      $       $       �    ?           "       "   �      "       "       �    @                       �                      �    A           '       '   �      '       '       �    B                                         �    C                     /                    �    D                     N                    �    E                     \                    �    F                     y                    �    G                     �                    �    H           	       	   �      	       	       �    I           !       !   �      !       !       �    J                     �                    �    K                     �                    �    L                       �                      �    M                     �                    �    N                     �                    �    O                     �                    �    P                                             �    Q                                         �    R                                         �    S           ,       ,   *      ,       ,       �    T           !       !   W      !       !       �    U                       y                      �    V           %       %   z      %       %       �    W           $       $   �      $       $       �    X           /       /   �      /       /       �    Y                     �                    �    Z                       �                      �    [                     �                    �    \                                             �    ]           /       /   )      /       /       �    ^           '       '   Y      '       '       �    _                       �                      �    `           (       (   �      (       (       �    a           #       #   �      #       #       �    b           6       6   �      6       6       �    c                     	                    �    d                      	                     5�_�                     5       ����                                                                                                                                                                                                                                                                                                                                                             b�(    �   d            �   c   e              }�   b   d          6        assert_eq!(x, [0.12, 2.34352, 2.231231, 2.3]);�   a   c          #        assert_eq!(e.lowest, 0.12);�   `   b          (        assert_eq!(e.greatest, 2.34352);�   _   a           �   ^   `          '        let e = ExtremaNoRefs::new(&x);�   ]   _          /        let x = [0.12, 2.34352, 2.231231, 2.3];�   \   ^               fn extrema_no_refs_works() {�   [   ]              #[test]�   Z   \           �   Y   [              }�   X   Z          /        assert_eq!(x, [12, 23, -221, -2, 123]);�   W   Y          $        assert_eq!(*e.lowest, -221);�   V   X          %        assert_eq!(*e.greatest, 123);�   U   W           �   T   V          !        let e = Extrema::new(&x);�   S   U          ,        let x = vec![12, 23, -221, -2, 123];�   R   T              fn extrema_works() {�   Q   S              #[test]�   P   R           �   O   Q              use super::*;�   N   P          mod tests {�   M   O          #[cfg(test)]�   L   N           �   K   M          }�   J   L              }�   I   K          !        Self { greatest, lowest }�   H   J          	        }�   G   I                      }�   F   H                          lowest = *i;�   E   G                      if i < &lowest {�   D   F                      }�   C   E                          greatest = *i;�   B   D                      if i > &greatest {�   A   C          '        for i in slice.iter().skip(1) {�   @   B           �   ?   A          "        let mut lowest = slice[0];�   >   @          $        let mut greatest = slice[0];�   =   ?          %    pub fn new(slice: &[V]) -> Self {�   <   >           �   ;   =              /// ```�   :   <          #    /// assert_eq!(e.lowest, 0.12);�   9   ;          (    /// assert_eq!(e.greatest, 2.34352);�   8   :              ///�   7   9          '    /// let e = ExtremaNoRefs::new(&x);�   6   8          /    /// let x = [0.12, 2.34352, 2.231231, 2.3];�   5   7              ///�   4   6          7    /// use implementor::basic::extrema::ExtremaNoRefs;�   3   5              /// ```�   2   4              /// # Example�   1   3          ?    /// This copies the values meaning this is not so effecient�   0   2          7    /// Get the greatest and lowest values in an array.�   /   1          {�   .   0          #    V: std::cmp::PartialOrd + Copy,�   -   /          where�   ,   .          impl<V> ExtremaNoRefs<V>�   +   -           �   *   ,          }�   )   +              pub lowest: V,�   (   *              pub greatest: V,�   '   )          pub struct ExtremaNoRefs<V> {�   &   (          #[derive(PartialEq, Debug)]�   %   '           �   $   &          }�   #   %              }�   "   $          !        Self { greatest, lowest }�   !   #          	        }�       "                      }�      !                          lowest = i;�                             if i < lowest {�                            }�                                greatest = i;�                            if i > greatest {�                '        for i in slice.iter().skip(1) {�                 �                #        let mut lowest = &slice[0];�                %        let mut greatest = &slice[0];�                (    pub fn new(slice: &'a [T]) -> Self {�                 �                    /// ```�                $    /// assert_eq!(*e.lowest, -221);�                %    /// assert_eq!(*e.greatest, 123);�                    ///�                !    /// let e = Extrema::new(&x);�                (    /// let x = [12, 23, -221, -2, 123];�                    ///�                1    /// use implementor::basic::extrema::Extrema;�                    /// ```�                    /// # Example�   
             6    /// Get the greatest and lowest values in an array�   	             {�      
              T: std::cmp::PartialOrd,�      	          where�                impl<'a, T> Extrema<'a, T>�                 �                }�                    pub lowest: &'a T,�                    pub greatest: &'a T,�                pub struct Extrema<'a, T> {�                 #[derive(PartialEq, Debug)]�   d   e          }�   4   6   e      0    /// use implementor::extrema::ExtremaNoRefs;5��    4                     �                     �    d                      	                     �                                                �                                              �                         8                     �                         Q                     �                         h                     �                           j                       �                         k                     �                         �                     �                         �                     �    	                     �                     �    
           6       6   �       6       6       �                         �                     �                         �                     �               1       1          1       1       �                         2                    �               (       (   :      (       (       �               !       !   c      !       !       �                         �                    �               %       %   �      %       %       �               $       $   �      $       $       �                         �                    �                           �                      �               (       (   �      (       (       �               %       %         %       %       �               #       #   4      #       #       �                           X                      �               '       '   Y      '       '       �                         �                    �                         �                    �                         �                    �                         �                    �                         �                    �                                              �    !           	       	         	       	       �    "           !       !         !       !       �    #                     =                    �    $                     C                    �    %                       E                      �    &                     F                    �    '                     b                    �    (                     �                    �    )                     �                    �    *                     �                    �    +                       �                      �    ,                     �                    �    -                     �                    �    .           #       #   �      #       #       �    /                     �                    �    0           7       7   �      7       7       �    1           ?       ?   (      ?       ?       �    2                     h                    �    3                     z                    �    4           7       7   �      7       7       �    5                     �                    �    6           /       /   �      /       /       �    7           '       '   �      '       '       �    8                                         �    9           (       (   &      (       (       �    :           #       #   O      #       #       �    ;                     s                    �    <                                             �    =           %       %   �      %       %       �    >           $       $   �      $       $       �    ?           "       "   �      "       "       �    @                       �                      �    A           '       '   �      '       '       �    B                                         �    C                     6                    �    D                     U                    �    E                     c                    �    F                     �                    �    G                     �                    �    H           	       	   �      	       	       �    I           !       !   �      !       !       �    J                     �                    �    K                     �                    �    L                       �                      �    M                     �                    �    N                     �                    �    O                     �                    �    P                                             �    Q                                         �    R                                         �    S           ,       ,   1      ,       ,       �    T           !       !   ^      !       !       �    U                       �                      �    V           %       %   �      %       %       �    W           $       $   �      $       $       �    X           /       /   �      /       /       �    Y                     �                    �    Z                                             �    [                                         �    \                                             �    ]           /       /   0      /       /       �    ^           '       '   `      '       '       �    _                       �                      �    `           (       (   �      (       (       �    a           #       #   �      #       #       �    b           6       6   �      6       6       �    c                     	                    �    d                      	                     5��