PRO spatialsubset
  COMPILE_OPT IDL2
  ;开始一个无窗口的应用程序
  e=ENVI()
  ;输入研究区左上角十进制纬度，当研究区处于南纬时，前面加负号
  UpperLeftLat = 19.433194
  ;输入研究区左上角十进制经度，当研究区处于西经时，前面加负号
  UpperLeftLon = -155.291805
  ;输入研究区右上角十进制纬度，当研究区处于南纬时，前面加负号
  LowerRightLat = 19.408194
  ;输入研究区右上角十进制经度，当研究区处于西经时，前面加负号
  LowerRightLon = -155.266805
  ;从ENVI目录下找到数字高程模型的地址
  GMTED2010_address = filepath('GMTED2010.jp2', $
     root_dir = e.root_dir,$
      subdirectory = ['data'])
  ;打开数字高程模型
  GMTED2010 = e.OpenRaster(GMTED2010_address)
  ;赋予这一个DEM一个编号
  DEMFID=ENVIRasterToFID(GMTED2010)
  ;查询这一个DEM的信息
  ENVI_FILE_QUERY,DEMFID,$
    data_gains=data_gains,$
    ns=Mul_ns,$
    nl=Mul_nl,$
    nb=Mul_nb,$
    dims=dims,$
    data_offsets=data_offsets,$
    bnames=bnames,$
    r_fid=DEM_fid
  ;获得数字高程模型的空间参考
  SpatialRef = GMTED2010.SPATIALREF
  ;按照提供的研究区经纬度，裁剪数字高程模型
  Subset = ENVISubsetRaster(GMTED2010, $
    SPATIALREF=SpatialRef, $
    SUB_RECT=[UpperLeftLon,$
     LowerRightLat, $
     LowerRightLon, $
     UpperLeftLat],$
      BANDS=0)
  ;统计裁剪部分的信息
  stats = ENVIRasterStatistics(Subset)
  ;获得裁剪部分的像元平均值，也就是研究区的平均高程
  elevation = stats.MEAN
  ;打印输出
  print,elevation
  ;打开一个ENVI窗口
  view = e.GetView()
  ;将裁剪后的图像显示在ENVI窗口中
  layer = view.CreateLayer(Subset)
  ;弹窗显示
  rlt=DIALOG_MESSAGE('The average elevation is '+strtrim(elevation,2)+' m',$
    title='Message',$
    /Information)
END