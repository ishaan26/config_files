Vim�UnDo� ��?��c~�㓦�1n��csjQ�H6py-I\�	�                                      bB�    _�                             ����                                                                                                                                                                                                                                                                                                                                                             bB�    �   
            �   	                 w.push('d');�      
          &    let mut w = ref_cell.borrow_mut();�      	              assert_eq!(r.len(), 5);�                    let r = ref_cell.borrow();�                7    let ref_cell = RefCell::new(String::from("Hello"));�                !fn ref_cell_borrow_will_panic() {�                #[should_panic]�                #[test]�                 �                 use std::cell::RefCell;�   
             }5��    
                      �                      �                                                �                                                  �                                              �                         !                     �               !       !   1       !       !       �               7       7   S       7       7       �                         �                     �                         �                     �               &       &   �       &       &       �    	                     �                     �    
                      �                      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             bB�    �                �               #[bench]�              �                 use std::cell::RefCell;�                 �                #[test]�                #[should_panic]�                #[bench]�                !fn ref_cell_borrow_will_panic() {�                7    let ref_cell = RefCell::new(String::from("Hello"));�      	              let r = ref_cell.borrow();�      
              assert_eq!(r.len(), 5);�   	             &    let mut w = ref_cell.borrow_mut();�   
                 w.push('d');�                }5��                          1                      �                          1                      �                        3                     �                                               �                                                �                                                  �                                              �                         !                     �                         1                     �               !       !   :       !       !       �               7       7   \       7       7       �                         �                     �                         �                     �    	           &       &   �       &       &       �    
                     �                     �                                               5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             bB�v    �               #[test, benchmarking]5��                                               �                        !                     �                        !                     5��