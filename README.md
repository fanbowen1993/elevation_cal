# elevation_cal
GMTED2010（全称全球多分辨率地形高程数据2010，Global Multi-resolution Terrain Elevation Data 2010）是美国地质调查局和美国国家地理空间情报局合作开发的高程数据集.软件运行流程：（1）用户输入研究区左上角十进制纬度、左上角十进制经度、右上角十进制纬度、右上角十进制经度；（2）系统读取数字高程模型GMTED2010；（3）执行ENVISubsetRaster 函数，按照经纬度裁剪数字高程模型；（4）统计裁剪部分的信息，计算裁剪部分的像元平均值，也就是研究区的平均高程；
