IF OBJECT_ID('[dbo].[FR_AgregarNVDetalleSoftland]') IS NOT NULL BEGIN
	DROP PROCEDURE [dbo].[FR_AgregarNVDetalleSoftland]
	PRINT ('Procedimiento [dbo].[FR_AgregarNVDetalleSoftland] eliminado exitosamente')
END

GO
/*------------------------------------------------------------------------------*/
/*-- Empresa			: DISOFI												*/
/*-- Tipo				: Procedimiento											*/
/*-- Nombre				: [dbo].[FR_AgregarNVDetalleSoftland]								*/
/*-- Detalle			:														*/
/*-- Autor				: FDURAN												*/
/*-- Modificaciones		:														*/
/*------------------------------------------------------------------------------*/
create PROCEDURE [dbo].[FR_AgregarNVDetalleSoftland]
(
	@pi_IdNotaVenta INT
,	@pi_IdDetalleNotaVenta INT
,	@pv_BaseDatos varchar(100)
,	@pb_Verificador BIT OUTPUT
,	@pv_Mensaje VARCHAR(max) OUTPUT
,	@pi_NVNumero INT OUTPUT
)
AS
	declare @query nvarchar(max)

	select @query = ''

	select @query = '
	DECLARE @NOMBRE_COLUMNA VARCHAR(MAX)
	DECLARE @QUERY_FINAL VARCHAR(MAX)
	DECLARE @QUERY_INSERT VARCHAR(MAX)
	DECLARE @QUERY_SELECT VARCHAR(MAX)
	DECLARE @QUERY_INSERT_COLUMNAS VARCHAR(MAX)
	DECLARE @QUERY_SELECT_COLUMNAS VARCHAR(MAX)
	
	SELECT	@QUERY_FINAL = ''''
	SELECT	@QUERY_INSERT = ''''
	SELECT	@QUERY_SELECT = ''''
	SELECT	@QUERY_INSERT_COLUMNAS = ''''
	SELECT	@QUERY_SELECT_COLUMNAS = ''''

	DECLARE CURSOR_COLUMNAS CURSOR FOR
		SELECT	COLUMN_NAME
		FROM	[' + @pv_BaseDatos + '].INFORMATION_SCHEMA.COLUMNS
		WHERE	TABLE_NAME = ''nw_detnv''

	OPEN CURSOR_COLUMNAS

	FETCH NEXT FROM CURSOR_COLUMNAS
	INTO @NOMBRE_COLUMNA

	WHILE @@FETCH_STATUS = 0 BEGIN
		SELECT	@QUERY_INSERT_COLUMNAS = @QUERY_INSERT_COLUMNAS + 
''		['' + @NOMBRE_COLUMNA + '']
,''

		SELECT	@QUERY_SELECT_COLUMNAS = @QUERY_SELECT_COLUMNAS + 
''		['' + @NOMBRE_COLUMNA + '']
,''

		FETCH NEXT FROM CURSOR_COLUMNAS
		INTO @NOMBRE_COLUMNA
	END
	
	SELECT	@QUERY_INSERT_COLUMNAS = SUBSTRING(@QUERY_INSERT_COLUMNAS, 1, LEN(@QUERY_INSERT_COLUMNAS) - 3)
	SELECT	@QUERY_SELECT_COLUMNAS = SUBSTRING(@QUERY_SELECT_COLUMNAS, 1, LEN(@QUERY_SELECT_COLUMNAS) - 3)

	SELECT	@QUERY_INSERT = ''
INSERT INTO [' + @pv_BaseDatos + '].[softland].[nw_detnv]
(
'' + @QUERY_INSERT_COLUMNAS + ''
)''
	SELECT	@QUERY_SELECT = ''
SELECT	
'' + @QUERY_SELECT_COLUMNAS + ''
FROM	[dbo].[DS_NotasVentaDetalle] 
WHERE	IdNotaVenta = ' + CONVERT(VARCHAR(20), @pi_IdNotaVenta) + '
AND		Id = ' + CONVERT(VARCHAR(20), @pi_IdDetalleNotaVenta) + '''

	SELECT	@QUERY_FINAL = @QUERY_INSERT + @QUERY_SELECT

	EXEC (@QUERY_FINAL)

	CLOSE CURSOR_COLUMNAS
	DEALLOCATE CURSOR_COLUMNAS
	'

	select	@pb_Verificador = cast(1 as bit)
	,		@pv_Mensaje = 'Nota Venta Agregado Satisfactoriamente'

	EXEC sp_executesql	@query
	,					N'@NVNumero INT OUTPUT',
	@pi_NVNumero OUTPUT;
GO

IF OBJECT_ID('[dbo].[FR_AgregarNVDetalleSoftland]') IS NOT NULL BEGIN
	PRINT ('Procedimiento [dbo].[FR_AgregarNVDetalleSoftland] creado exitosamente')
END
ELSE BEGIN
	PRINT ('Error al crear procedimiento [dbo].[FR_AgregarNVDetalleSoftland]')
END
GO