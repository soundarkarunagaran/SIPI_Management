   M S B A M L   `   `   `  ����  SIPI_SL>    8SIPI_SL.UI.ResultManagement.MarksDistributionToStudentUI   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35n jSAPBusinessObjects.WPF.ViewerShared, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	     � Title$&   Marks Distribution To Student UI��5   	   $	��606��62   $
��1063��6?    � WindowState$ 	Maximized=�5   	    � WindowStartupLocation$ CenterScreen=�6!    � 
ResizeMode$ CanMinimize=�5   	      	GrayWhite#��[  6#    � ShowInTaskbar .  .��5      � .+�5   
   � $��
85,10,77,0q�6   $��Center=�6#   #��� ��6@   $	��895��6�   $	��557��6�   $	��Top=�6�   .+�5	      �� -   5        $��departmentCombobox��5	      $
��Left=�61   $��
142,22,0,0q�6L   $	��Top=�6`   $	��254��6x     ComboBoxBGYellowGreen#��[ 6�   �� 5
      $��
Department��6   $
��Left=�6*   $��	32,22,0,0q�6E   $	��Top=�6X   $	��106��6p   �� 5      -   5        $��semesterCombobox��5      $
��Left=�6/   $��142,100,0,0q�6J   $	��Top=�6_   $	��119��6w   #��[ 6�   �� 5      $��Semester��6   $
��Left=�6(   $��
32,100,0,0q�6C   $	��Top=�6W   $	��110��6o   �� 5      -   5        $��yearCombobox��5      $
��Left=�6+   $��142,139,0,0q�6F   $	��Top=�6[   $	��119��6s   #��[ 6   �� 5      $
��Year��6   $
��Left=�6$   $��
34,139,0,0q�6?   $	��Top=�6S   $��66��6k   �� 5      -   5        $��searchButton��5   �   $�� ��6   $
��Left=�6    $��266,100,0,0q�6;   $	��Top=�6P   $	��130��6h   $��73��6t     SearchButton#���  6�   6�   �� 5      -   5        $��marksEntryButton��5   �   $��Entry��6   $
��Left=�6%   $��763,528,0,0q�6@   $	��Top=�6U   $	��108��6m   $��24��6y   6�   &   System.Windows.Controls.DataGrid  5      -   5        $��StudentMarksEntryDataGrid��5   #      AutoGenerateColumns .  $��Center=�5   )   $��20,178,24,34q�5      $	��851��6D      CanUserAddRows .     Columns 5      0  *System.Windows.Controls.DataGridTextColumn  5      ,  &System.Windows.Controls.DataGridColumn   Header$ 
Department��6)   	   Width5  /System.Windows.Controls.DataGridLengthConverter$
	 auto 6e   
   
IsReadOnly
 . 1  +System.Windows.Controls.DataGridBoundColumn   Binding 6=   ��  �� Path$ DepartmentName�6r     5      $ Semester��6)   $
	 auto 6_   
 .  6;   �� $ 
SemesterNo�6l     5      $ Student Name��6)   $
	 auto 6d   
 .  6?   �� $ StudentName�6q     5      $ 
Srudent Id��6)   $
	 auto 6`   
 .  6=   �� $ 	StudentId�6m   4  .System.Windows.Controls.DataGridTemplateColumn  5      $ Theoty Con. Asses��6-   $		 100 6H   
 .    CellTemplate 5      �� 5      .R�5    "   �� $��theotyConAssesTextBox��6+   -   5        ��5    y   �� $ TheoryMarksConAssess� �� Mode$ TwoWay=� �� UpdateSourceTrigger$ PropertyChanged=�5!      5#        5$      $ Practical Con. Asses��6-   $		 100 6K   
 .  5%      �� 5&      .R�5'   "   �� $��PracticalConAssesTextBox��6+   -   5        ��5'      �� $ PracticalMarksConAssess�$ TwoWay=�$ PropertyChanged=�5(      5*        5+      $ Theoty Final Exam��6-   $		 100 6H   
 .  5,      �� 5-      .R�5.   "   �� $��theotyFinalExamTextBox��6+   -	   5        ��5.   {   �� $ TheoryMarksFinalExam�$ TwoWay=�$ PropertyChanged=�5/      51        52      $ Practical Final Exam��6-   $		 100 6K   
 .  53      �� 54      .R�55   "   �� $��practicalFinalExamTextBox��6+   -
   5        ��55   �   �� $ PracticalMarksFinalExam�$ TwoWay=�$ PropertyChanged=�56      58        5:      $ Total Marks��6)   $
	 auto 6b   
 .  6>   �� $ 
TotalMarks�6o   5<      �� 5=      -   5        $��courseCombobox��5=      $
��Left=�6-   $��
142,61,0,0q�6H   $	��Top=�6\   $	��254��6t   #��[ 6�   �� 5>      $��Course��6   $
��Left=�6&   $��	34,61,0,0q�6A   $	��Top=�6T   $	��108��6l   5?      5@      5A      