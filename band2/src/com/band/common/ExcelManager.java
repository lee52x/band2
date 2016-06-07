package com.band.common;

import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.band.account.Account;
import com.band.account.AccountService;

@Service("excelManager")
public class ExcelManager {

	@Autowired
	private AccountService service;
	
	public void ExcelRoad(String pathname, String url, String option) throws Exception {
		if(option.equalsIgnoreCase("form")){
			try {
				POIFSFileSystem fs=new POIFSFileSystem(new FileInputStream(pathname));
				
				// 워크북 생성
				HSSFWorkbook workbook=new HSSFWorkbook(fs); // 파일에 대한 워크북 생성
				int sheetNum=workbook.getNumberOfSheets(); // 워크 시트 수
				
					
				// 데이터 가져오기
				for(int i=0; i<sheetNum; i++){
					
					// 시트에 대한 정보를 담는다
					HSSFSheet sheet=workbook.getSheetAt(i);
					
					// 그 시트의 열 수 구하기
					int rows=sheet.getPhysicalNumberOfRows();
					
					gogo:
						
					for(int r=0; r<rows; r++){
						// 한줄씩 추출
						Account dto=new Account();
						HSSFRow row=sheet.getRow(r); // 시트에 몇 개의 열이 있는지 체크
						
						if(row!=null&&r!=0){
								//int cells=row.getPhysicalNumberOfCells(); // 한개의 열마다 몇개의 행이 있는지 

								for(short c=0; c<5; c++){
									HSSFCell cell=row.getCell(c);
									SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
									
									if(cell==null){
										if(c==0){ // 날짜 입력 안되면 break
											break gogo;
										}else if(c==1){
											dto.setTranName(null);
										}else if(c==2){
											dto.setTranData(null);
										}else if(c==3){
											dto.setDeposit(0);
										}else if(c==4){
											dto.setWithdrawal(0);
										}
									}
									if(cell!=null){
										String value=null;
										int val=0;
										
										if(c==0){ 
											Date date = cell.getDateCellValue();
											value = sdf.format(date);
											dto.setTranDate(value);
										}else if(c==1){
											value = cell.getStringCellValue();
											dto.setTranName(value);
										}else if(c==2){
											value = cell.getStringCellValue();
											dto.setTranData(value);
										}else if(c==3){
											val = (int)cell.getNumericCellValue();
											dto.setDeposit(val);
										}else if(c==4){
											val = (int)cell.getNumericCellValue();
											dto.setWithdrawal(val);
										}
									}
								}
								dto.setUrl(url);
								service.insertAccount(dto);
						}
					} // 모든 데이터 읽어서 dto에 담음
				}
			} catch (Exception e) {
				System.out.println(e.toString());
			}
		/******************************************************************
		 * 우리은행
		 ******************************************************************/
		}else if(option.equalsIgnoreCase("woori")){
			try {
				POIFSFileSystem fs=new POIFSFileSystem(new FileInputStream(pathname));
				
				// 워크북 생성
				HSSFWorkbook workbook=new HSSFWorkbook(fs); // 파일에 대한 워크북 생성
				int sheetNum=workbook.getNumberOfSheets(); // 워크 시트 수
				
					
				// 데이터 가져오기
				for(int i=0; i<sheetNum; i++){
					
					// 시트에 대한 정보를 담는다
					HSSFSheet sheet=workbook.getSheetAt(i);
					
					// 그 시트의 열 수 구하기
					int rows=sheet.getLastRowNum();
					
						
					for(int r=0; r<rows+1; r++){
						// 한줄씩 추출
						Account dto=new Account();
						HSSFRow row=sheet.getRow(r); // 시트에 몇 개의 열이 있는지 체크
						
						if(row!=null&&r>8){

							for(short c=0; c<6; c++){
								HSSFCell cell=row.getCell(c);
								
								if(cell!=null){
									String value=null;
									int val=0;
									
									if(c==0){ 
										String date = cell.getStringCellValue();
										value = date.substring(0, 10);
										dto.setTranDate(value);
									}else if(c==1){
										value = cell.getStringCellValue();
										dto.setTranData(value);
									}else if(c==2){
										value = cell.getStringCellValue();
										dto.setTranName(value);
									}else if(c==3){
										val = (int)cell.getNumericCellValue();
										dto.setWithdrawal(val);
									}else if(c==4){
										val = (int)cell.getNumericCellValue();
										dto.setDeposit(val);
									}
								}
							}
							dto.setUrl(url);
							service.insertAccount(dto);
						}
					} // 모든 데이터 읽어서 dto에 담음
				}
			} catch (Exception e) {
				System.out.println(e.toString());
			}
		}
	}
}
