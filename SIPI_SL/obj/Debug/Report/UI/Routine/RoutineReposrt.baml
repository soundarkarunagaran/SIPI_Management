   M S B A M L   `   `   `  ����  SIPI_SL.    (SIPI_SL.Report.UI.Routine.RoutineReposrt   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35n jSAPBusinessObjects.WPF.ViewerShared, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   a
extToolkitJhttp://schemas.microsoft.com/winfx/2006/xaml/presentation/toolkit/extended     5   	     � Title$  Routine Report��5   	   $��359.356��6    $��621.197��61      	GrayWhite#��[  6B    � ShowInTaskbar .   � WindowStartupLocation$ CenterScreen=�6�   .��5      � .+�5	   
   � .+�5
      �� -   5        $��yearTextBox��5
      $�� ��6   $��15(�61    J� SnapsToDevicePixels .   �� SelectionBrush �	#FF5677B1$��
336,33,0,0q�6v   $��35��6�   $	��Top=�6�   $
��Left=�6�   $��92��6�   �� 5      -   5        $��previewReportButton��5   �   $��Preview��6   $
��Left=�6'   $	��Top=�6B   $��75��6Z   $��
514,35,0,0q�6e   $��24��6y   6�   �� 5      -   5        $��searchButton��5   �   $��Search��6   $
��Left=�6&   $	��Top=�6A   $��75��6Y   $��
433,35,0,0q�6d   $��24��6x   6�   �� 5      $��
Department��6   $
��Left=�6)   $��51,0,0,0q�6D   $	��Top=�6V   $	��152��6n   $��30��6z   $��15(�6�   $
��Bold"�6�   �� 5      $��Semester��6   $
��Left=�6'   $��	210,0,0,0q�6B   $	��Top=�6U   $	��123��6m   $��30��6y   $��15(�6�   $
��Bold"�6�   �� 5      -   5        $��departmentCombobox��5   !    �� 
IsEditable .  w� TextPath$ SIPI_DepartmentName��5   !   $
��Left=�5   !   $��	51,35,0,0q�5   !   $	��Top=�5   !   $	��152��5   !    J� RenderTransformOrigin$ 0.037,0.146&�5   !   $��33��5   ;   ��5      �� 5      .R�5      ��  �� Orientation$ 
Horizontal=�6%   .+�5      �� $	��130��6M   ��6(   �� *SIPI_DepartmentName+6M   5       5!      5#      �� 5$      -   5        	 ��Name$	 semesterCombobox��5,       . $ 
SemesterNo��5&      $
��Left=�5'      $��
208,34,0,0q�5(      $	��Top=�5)      $	��123��5*      $ 0.037,0.146&�5+      $��34��5,   (   ��5-      �� 5.      .R�5/      �� $ 
Horizontal=�6%   .+�51      �� $	��130��6D   ��6(   �� *
SemesterNo+6D   53      54      56      �� 57      $
��Year��6   $
��Left=�6#   $��	336,0,0,0q�6>   $	��Top=�6Q   $��92��6i   $��30��6t   $��15(�6�   $
��Bold"�6�   58      �� 5:   
   -   5        $��allRoutineListView��5;      $
��Left=�5:      $	��211��6.   $��	49,77,0,0q�6;   $	��Top=�6N   $	��518��6f      alternatingListViewItemStyle#��[ 5;   -   
 �� View
 5>      �� 5?       �� AllowsColumnReorder . .P�5@      �� $�� ��6I    �� Width$ 0��6S    �� DisplayMemberBinding 6%   �� *Id+6S   �� 5A      $��
Department��6U   $	 100��6i    6%   �� *DepartmentName+6i   �� 5B      $��	Semester ��6Q   $	 100��6d    6%   �� *
SemesterNo+6d   �� 5C      $
��Day ��6J   $	 100��6X    6%   �� *Day+6X   �� 5D      $��Firstclass ��6U   $	 100��6j    6%   �� *FirstClassName+6j   �� 5E      $��Last Class ��6V   $	 100��6k    6%   �� *FirstCourseName+6k   �� 5F      $��Year ��6K   $	 100��6Z    6%   �� *Year+6Z   5H      5J      �� 5K   
   -   5         ��Name$$ previewReportButton_department��5K   �   $��Department Wise Routine��6   $
��Left=�63   $	��Top=�6N   $	��166��6f   $��437,293,0,0q�6r   $��24��6�   6�   5M      5N      