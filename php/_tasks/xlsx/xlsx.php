<?php

require 'vendor/autoload.php';

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

$spreadsheet = new Spreadsheet();
$sheet = $spreadsheet->getActiveSheet();
$sheet->setCellValue('A1', 'Hello World !');


// // Set outline levels
// for ($row = 2; $row <= 10; ++$row) {
//     $objPHPExcel->getActiveSheet()
//         ->getRowDimension($row)
//             ->setOutlineLevel(1)
//             ->setVisible(false)
//             ->setCollapsed(true);
// }

// for ($row = 4; $row <= 9; ++$row) {
//     $objPHPExcel->getActiveSheet()
//         ->getRowDimension($row)
//             ->setOutlineLevel(2)
//             ->setVisible(false)
//             ->setCollapsed(true);
// }
// for ($row = 6; $row <= 8; ++$row) {
//     $objPHPExcel->getActiveSheet()
//         ->getRowDimension($row)
//             ->setOutlineLevel(3)
//             ->setVisible(false)
//             ->setCollapsed(true);
// }


// Set outline levels
for ($row = 2; $row <= 10; ++$row) {
    $spreadsheet->getActiveSheet()
        ->getRowDimension($row)
        ->setOutlineLevel(1)
        ->setVisible(false)
        ->setCollapsed(true);
}

for ($row = 4; $row <= 9; ++$row) {
    $spreadsheet->getActiveSheet()
        ->getRowDimension($row)
            ->setOutlineLevel(2)
            ->setVisible(false)
            ->setCollapsed(true);
}
for ($row = 6; $row <= 8; ++$row) {
    $spreadsheet->getActiveSheet()
        ->getRowDimension($row)
            ->setOutlineLevel(3)
            ->setVisible(false)
            ->setCollapsed(true);
}


$writer = new Xlsx($spreadsheet);
$writer->save('hello world.xlsx');
