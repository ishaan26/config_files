Vim�UnDo� yJ"a�Pe���Hi��qs<�\I���P��   '                                   bC�    _�                              ����                                                                                                                                                                                                                                                                                                                                                             bC�    �   &            �   %   '              }�   $   &          /        assert_eq!(vec![1, 2, 3, 4, 5], slice);�   #   %          5        StdSorter { stable: false }.sort(&mut slice);�   "   $          ,        let mut slice = vec![1, 3, 2, 5, 4];�   !   #              fn unstable_sort_works() {�       "              #[test]�      !           �                     }�                /        assert_eq!(vec![1, 2, 3, 4, 5], slice);�                4        StdSorter { stable: true }.sort(&mut slice);�                ,        let mut slice = vec![1, 3, 2, 5, 4];�                    fn stable_sort_works() {�                    #[test]�                 �                    use super::*;�                 �                mod tests {�                #[cfg(test)]�                 �                }�                    }�                	        }�                !            slice.sort_unstable()�                        } else {�                            slice.sort()�                        if self.stable {�                    {�   
                     T: Ord,�   	             	    where�      
          &    fn sort<T>(&self, slice: &mut [T])�      	              #[inline]�                impl Sorter for StdSorter {�                 �                }�                    pub stable: bool,�                pub struct StdSorter {�                 �                 use crate::orst::Sorter;�   &   '          }�      	   &    �         &    5��                          f                      �    &                      �                     �                                                �                                                  �                                              �                         1                     �                         G                     �                           I                       �                         J                     �                         f                     �               &       &   t       &       &       �    	           	       	   �       	       	       �    
                     �                     �                         �                     �                         �                     �                         �                     �                         �                     �               !       !   �       !       !       �               	       	          	       	       �                         *                    �                         0                    �                           2                      �                         3                    �                         @                    �                           L                      �                         M                    �                           _                      �                         `                    �                         l                    �               ,       ,   �      ,       ,       �               4       4   �      4       4       �               /       /   �      /       /       �                                             �                           !                      �                          "                    �    !                     .                    �    "           ,       ,   M      ,       ,       �    #           5       5   z      5       5       �    $           /       /   �      /       /       �    %                     �                    �    &                      �                     5��