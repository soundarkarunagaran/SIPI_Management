   M S B A M L   `   `   `  ����  SIPI_SL'    !SIPI_SL.UI.Admission.BloodGroupUI   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35n jSAPBusinessObjects.WPF.ViewerShared, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	     � Title$  Blood Group UI��5   	   $��337.363��6    $��353.846��61      	GrayWhite#��[  6A    � ShowInTaskbar .   � WindowStartupLocation$ CenterScreen=�6   .��5      � $��0,0,0,-2q�6   .+�5   
   �� $��Blood Group��6   $
��Left=�6(   $��	27,10,0,0q�6C   $	��Top=�6V   $	��119��6n   $	��294��6{   .��5      � .+�5      �� $��Blood Group��6   $
��Left=�6.   $��35��6I   $	��Top=�6U   $��80��6m   $��	10,10,0,0q�6x   �� 5	      -   5        $��bloodGroupTextBox��5	      $��114,10,10,0q�63   $��28��6H   $	��Top=�6T   �� 5
      -   5        $��submitButton��5
   \   $��131,57,10,0q�6   $
��Save��6/   $��28��6p   $	��Top=�6|    J� RenderTransformOrigin$ 
0.909,2.21&�6�   5      5      �� 5   
   $��Blood Group��6   $
��Left=�6(   $��
27,134,0,0q�6C   $	��Top=�6W   $	��156��6o   $	��294��6|   .��5      � $
��Left=�6   $	��127��6.   $	��Top=�6;   $	��284��6S   $��0,0,-2,0q�6_    � ColumnDefinitions 5      �� 5      $��2* �6'   �� 5      $
��211* �6'   .+�5      �� -   5        $��bloodGroupListView��5      $	��107��5      $��	10,10,0,0q�5      $	��Top=�5      $��1��61   $
��Left=�6A   $	��261��6\      alternatingListViewItemStyle#��[ 5       �� AlternationCount$ 2��6\    � ContextMenu 5      �� 5      -   5        $��ZoneIformationList��5   &    �� 	StaysOpen . 
������� J� BitmapEffect 5      �� 5   "   .@�5      m� -   5        $��EditBloodGroupContextMenu��5   5   $
��Edit��6'   6V   m� 5      -   5        $!��RemoveBloodGroupContextMenu��5   7   $��Remove��6'   6Z   5       	 �� View	 5"      �� 5#      
 �� AllowsColumnReorder
 . .P�5$      �� $�� ��6V    �� Width$ 0��6`    �� DisplayMemberBinding 6-   ��  �� Path$ Id�6`   �� 5%      $��Blood Group��6b   $	 300��6w    6-   �� $ BloodGroupName�6w   5(      5*      5+      5,      5/      52      