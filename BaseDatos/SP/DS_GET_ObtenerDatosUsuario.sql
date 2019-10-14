alter procedure DS_GET_ObtenerDatosUsuario
@IdUsuario int
AS
SELECT 
Usuario = u.Usuario,
Nombre = u.Nombre,
--Password = u.Contrasena,
email = u.email,
tipoId = u.tipoUsuario,
VenCod = u.VenCod,
VenDes = dut.tipoUsuario
FROM DS_Usuarios u 
JOIN dbo.DS_UsuariosTipos dut ON u.tipoUsuario = dut.id
WHERE u.ID = @IdUsuario	
