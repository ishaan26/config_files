Vim�UnDo� �i��=�c��2/�؁1�+������Or�A[   0                                   b9q"    _�                             ����                                                                                                                                                                                                                                                                                                                                                             b9q     �                 fn main() {5��                                                  5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             b9q      �                     println!("Hello, world!");5��                                                  5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             b9q      �                 }5��                                                 5�_�                             ����                                                                                                                                                                                                                                                                                                                                                             b9q!    �   /            �   .   0          )    // Compile-time Error: type mismatch.�   -   /          2    // Nonsensical operations fail as they should:�   ,   .           �   +   -          >    println!("one meter + one_meter = {:?} mm", two_meters.0);�   *   ,          :    println!("one foot + one_foot = {:?} in", two_feet.0);�   )   +              // Addition works.�   (   *           �   '   )          +    let two_meters = one_meter + one_meter;�   &   (          '    let two_feet = one_foot + one_foot;�   %   '          H    // `one_foot` and `one_meter` but copies them into `self` and `rhs`.�   $   &          A    // Since `Length` implements `Copy`, `add()` does not consume�   #   %              //�   "   $          F    // `+` calls the `add()` method we implemented for `Length<Unit>`.�   !   #           �       "          >    let one_meter: Length<Mm>   = Length(1000.0, PhantomData);�      !          3    // `one_meter` has phantom type parameter `Mm`.�                 <    let one_foot:  Length<Inch> = Length(12.0, PhantomData);�                B    // Specifies `one_foot` to have phantom type parameter `Inch`.�                fn main() {�                 �                }�                    }�                +        Length(self.0 + rhs.0, PhantomData)�                8        // `+` calls the `Add` implementation for `f64`.�                5    fn add(self, rhs: Length<Unit>) -> Length<Unit> {�                >    // add() returns a new `Length` struct containing the sum.�                 �                      type Output = Length<Unit>;�                !impl<Unit> Add for Length<Unit> {�                =/// The `Add` trait defines the behavior of the `+` operator.�                 �                ,struct Length<Unit>(f64, PhantomData<Unit>);�                #[derive(Debug, Clone, Copy)]�                ;/// `f64` already implements the `Clone` and `Copy` traits.�                ///�                </// and is not generic over the length type (that is `f64`).�   
             :/// `Length` is a type with phantom type parameter `Unit`,�   	              �      
          
enum Mm {}�      	          #[derive(Debug, Clone, Copy)]�                enum Inch {}�                #[derive(Debug, Clone, Copy)]�                2/// Create void enumerations to define unit types.�                 �                use std::marker::PhantomData;�                use std::ops::Add;�                  �   /   0          +    //let one_feter = one_foot + one_meter;   }�               5��                   0                      n      �    /                      A      .               �                                                  �                                              �                          1                      �                       2   2               2       �               2          e       2              �                         �                     �                         �                     �                      
   �              
       �               
           �       
               �    	                   :   �               :       �    
           :       <   �       :       <       �               <          2      <              �                      ;   6             ;       �               ;          r      ;              �                      ,   �             ,       �               ,           �      ,               �                       =   �              =       �               =       !   �      =       !       �               !                !              �                           >                      �                       >   ?              >       �               >       5   ~      >       5       �               5       8   �      5       8       �               8       +   �      8       +       �               +                +              �                                             �                          !                     �                          "                     �                      B   .             B       �               B       ;   q      B       ;       �               <       3   �      <       3       �               3       <   �      3       <       �                >                 >               �    !                   F                 F       �    "           F          f      F              �    #                  A   m             A       �    $           A       H   �      A       H       �    %           H       '   �      H       '       �    &           '       +          '       +       �    '           +           L      +               �    (                      M                     �    )                  :   d             :       �    *           :       >   �      :       >       �    +           >           �      >               �    ,                   2   �              2       �    -           2       )         2       )       �    .           )       +   <      )       +       �    /                      h                     5��