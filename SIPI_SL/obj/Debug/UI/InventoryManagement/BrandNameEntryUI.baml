   M S B A M L   `   `   `  ����  SIPI_SL5    /SIPI_SL.UI.InventoryManagement.BrandNameEntryUI   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35n jSAPBusinessObjects.WPF.ViewerShared, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	     � Title$  Brand Name Entry UI��5   	   $��402.724��6%   $��564.981��66    � WindowStartupLocation$ CenterScreen=�6F      	GrayWhite#��[  6k    � ShowInTaskbar .  .��5      � .+�5      �� $��
Brand Name��6   $
��Left=�6)   $��	29,21,0,0q�6D   $	��Top=�6W   $	��102��6o   �� 5      -   5        $��brandNameTextbox��5   �   $
��Left=�6   $��27��61   $��
149,20,0,0q�6=    �� TextWrapping$
 Wrap=�6Q   $	��Top=�6g   $	��222��6   6�   �� 5      $��
Dicription��6   $
��Left=�6)   $��	29,50,0,0q�6D   $	��Top=�6W   $	��102��6o   �� 5	      -   5        $��brandDiscriptionTextBox��5	   �   $
��Left=�6   $��52��61   $��
149,49,0,0q�6=   $
 Wrap=�6Q    �� AcceptsReturn . " �� VerticalScrollBarVisibility$ Visible=�6z   $	��Top=�6�   $	��222��6�   6�   �� 5
      $��Contact Info��6   $
��Left=�6+   $��
29,106,0,0q�6F   $	��Top=�6Z   $	��102��6r   �� 5      -   5        $��contactInfoTextbox��5   �   $
��Left=�6   $��27��61   $��149,105,0,0q�6=   $
 Wrap=�6R   $	��Top=�6h   $	��222��6�   6�   �� 5      -   5         ��Name$ 
saveButton��5   �   $
��Bold"�6   $��6q�6'   $
��SAVE��6;   $
��Left=�6J   $��469,102,0,0q�6e   $	��Top=�6z   $��78��6�   6�   �� 5      -   5        $ clearButton��5   �   $
��Bold"�6   $��6q�6'   $��Clear��6;   $
��Left=�6K   $��391,102,0,0q�6f   $	��Top=�6{   $��78��6�   6�   �� 5   
   -   5        $��brandNameListView��5   s   $
��Left=�6   $	��219��6.   $��
10,143,0,0q�6;   $	��Top=�6O   $	��537��6g    �� View 5      �� 5      .P�5      �� $��ID��6O    �� Width$ 0��6[   	 �� DisplayMemberBinding	 6%   �� 
 �� Path$
 Id�6[   �� 5      $��
Brand Name��6_   $
 Auto��6s   	 6%   �� $
 InventoryBrandName�6s   �� 5      $��Discription��6\   $
 Auto��6q   	 6%   �� $
 BrandDiscription�6q   �� 5      $��ContactInfo��6W   $
 Auto��6l   	 6%   �� $
 ContactInfo�6l   5      5      5      5      