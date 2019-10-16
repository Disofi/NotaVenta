using DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UTIL.Models;
using UTIL.Objetos;

namespace BLL
{
    public class FactoryAcceso
    {
        #region anterior

        public List<_NotaDeVentaDetalleModels> DatosCorreoVend(int NvNUmero)
        {
            var DatosUser = new List<_NotaDeVentaDetalleModels>();
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("SP_GET_DatosCorreoVend", new System.Collections.Hashtable()
                                                                                            {
                                                                                                {"NvNumero", NvNUmero}
                                                                                            });
                if (data.Rows.Count > 0)
                {
                    for (var i = 0; i < data.Rows.Count; i++)
                    {
                        var validador = new object();
                        var resultadoListado = new _NotaDeVentaDetalleModels();

                        validador = data.Rows[i].Field<object>("email");
                        resultadoListado.EmailVend = validador != null ? data.Rows[i].Field<string>("email") : "NO ASIGNADO";

                        validador = data.Rows[i].Field<object>("ContrasenaCorreo");
                        resultadoListado.PassCorreo = validador != null ? data.Rows[i].Field<string>("ContrasenaCorreo") : "NO ASIGNADO";

                        DatosUser.Add(resultadoListado);
                    }
                }
            }
            catch (SqlException ex)
            {
                new CapturaExcepciones(ex);
            }
            catch (Exception ex)
            {
                new CapturaExcepciones(ex);
            }
            return DatosUser;
        }

        public List<_NotaDeVentaDetalleModels> DatosCorreoAprobador(string VendCod)
        {
            var DatosUser = new List<_NotaDeVentaDetalleModels>();
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("SP_GET_DatosCorreoAprobador", new System.Collections.Hashtable()
                                                                                            {
                                                                                                {"VendCod", int.Parse(VendCod)}
                                                                                            });
                if (data.Rows.Count > 0)
                {
                    for (var i = 0; i < data.Rows.Count; i++)
                    {
                        var validador = new object();
                        var resultadoListado = new _NotaDeVentaDetalleModels();

                        validador = data.Rows[i].Field<object>("email");
                        resultadoListado.EmailVend = validador != null ? data.Rows[i].Field<string>("email") : "NO ASIGNADO";

                        validador = data.Rows[i].Field<object>("ContrasenaCorreo");
                        resultadoListado.PassCorreo = validador != null ? data.Rows[i].Field<string>("ContrasenaCorreo") : "NO ASIGNADO";

                        DatosUser.Add(resultadoListado);
                    }
                }
            }
            catch (SqlException ex)
            {
                new CapturaExcepciones(ex);
            }
            catch (Exception ex)
            {
                new CapturaExcepciones(ex);
            }
            return DatosUser;
        }

        public bool ActualizaCorreo(_UsuariosModels Usuario)
        {
            bool respuesta = false;
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("DS_SET_ActualizaCorreo", new System.Collections.Hashtable()
                                                                                            {
                                                                {"VendCod", Usuario.VenCod.Trim()},
                                                                {"Email", Usuario.email},
                                                                {"Contrasena", Usuario.Password}
                });
                if (data.Rows.Count > 0)
                {
                    respuesta = true;
                }
            }
            catch (SqlException ex)
            {
                new CapturaExcepciones(ex);
                respuesta = false;
            }
            catch (Exception ex)
            {
                new CapturaExcepciones(ex);
                respuesta = false;
            }
            return respuesta;
        }

        #endregion


        public List<ObjetoMenu> MenuUsuario(int idUsuario)
        {
            var listadoMenu = new List<ObjetoMenu>();
            var data = new DBConector().EjecutarProcedimientoAlmacenado("SP_GET_Menu", new System.Collections.Hashtable()
                                                                                            {
                                                                                                {"TipoUsuario", idUsuario}
                                                                                            });

            if (data.Rows.Count > 0)
            {
                for (var i = 0; i < data.Rows.Count; i++)
                {
                    var validador = new object();
                    var resultadoListado = new ObjetoMenu();
                    validador = data.Rows[i].Field<object>("Id_Menu");
                    resultadoListado.IdMenu = validador != null ? data.Rows[i].Field<int>("Id_Menu") : -1;

                    validador = data.Rows[i].Field<object>("Clase");
                    resultadoListado.Clase = validador != null ? data.Rows[i].Field<string>("Clase") : "NO ASIGNADO";

                    validador = data.Rows[i].Field<object>("PieMenu");
                    resultadoListado.PieMenu = validador != null ? data.Rows[i].Field<string>("PieMenu") : "NO ASIGNADO";

                    validador = data.Rows[i].Field<object>("Titulo");
                    resultadoListado.Titulo = validador != null ? data.Rows[i].Field<string>("Titulo") : "NO ASIGNADO";

                    validador = data.Rows[i].Field<object>("Action");
                    resultadoListado.Action = validador != null ? data.Rows[i].Field<string>("Action") : "NO ASIGNADO";

                    validador = data.Rows[i].Field<object>("Controller");
                    resultadoListado.Controller = validador != null ? data.Rows[i].Field<string>("Controller") : "NO ASIGNADO";


                    listadoMenu.Add(resultadoListado);
                }
            }
            return listadoMenu;
        }

        public List<CentrodeCostoModels> ListarCentroCosto(string basedatos)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_ListarCentroDeCosto", new System.Collections.Hashtable()
                {
                    { "pv_BaseDatos", basedatos},
                });

                return UTIL.Mapper.BindDataList<CentrodeCostoModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }


        public List<ClientesModels> GetClientes(string basedatos, ClientesModels cliente = null)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("JS_ListarClientesCodAuxRut", new System.Collections.Hashtable()
                {
                    { "vchrRutAux", cliente.RutAux},
                    { "vchrCodAux", cliente.CodAux},
                    { "pv_BaseDatos", basedatos},
                });
                return UTIL.Mapper.BindDataList<ClientesModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<ClientesModels> GetContacto(string basedatos, ClientesModels cliente = null)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("JS_ListarContactos", new System.Collections.Hashtable()
                {
                    { "vchrCodAux", cliente.CodAux},
                    { "pv_BaseDatos", basedatos},
                });
                return UTIL.Mapper.BindDataList<ClientesModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<ClientesModels> GetCliente(ClientesModels cliente = null)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("JS_ListarClientesCodAux", new System.Collections.Hashtable()
                {
                    { "vchrCodAux", cliente.CodAux},
                });
                return UTIL.Mapper.BindDataList<ClientesModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }


        public List<ClientesModels> listarClientes(string basedatos)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_ListarClientes", new System.Collections.Hashtable()
                {
                    {"pv_BaseDatos",basedatos}
                });
                return UTIL.Mapper.BindDataList<ClientesModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<EmpresaModel> ListarEmpresas()
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("DS_ListaEmpresa", new System.Collections.Hashtable()
                {
                });
                return UTIL.Mapper.BindDataList<EmpresaModel>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<ClientesModels> BuscarClientes(ClientesModels clientes)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_BuscarClientes", new System.Collections.Hashtable()
                {
                    { "RutAux", clientes.RutAux},
                    { "CodAux", clientes.CodAux},
                });
                return UTIL.Mapper.BindDataList<ClientesModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<ClientesModels> ListarClientesTodos()
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_ListarClientesTodos", new System.Collections.Hashtable()
                {
                });
                return UTIL.Mapper.BindDataList<ClientesModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        //Procedimiento devuelve clientes por su id//
        public List<ClientesModels> BuscarMisClientes(ClientesModels RutAux)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_ListarMisClientes", new System.Collections.Hashtable()
                {
                    { "ID", RutAux.ID},
                });
                return UTIL.Mapper.BindDataList<ClientesModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }


        //Busca los clientes por el VenCod del Usuario//
        public List<ClientesModels> BuscarMisClientesVenCod(UsuariosModels usuario, string basedatos)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("JS_ListarMisClientes", new System.Collections.Hashtable()
                {
                    { "cod", usuario.VenCod},
                    { "ID", usuario.id},
                    {"pv_BaseDatos",basedatos }
                });
                return UTIL.Mapper.BindDataList<ClientesModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<ClientesModels> BuscarContacto(string basedatos, ClientesModels contacto)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_ListarContactos", new System.Collections.Hashtable()
                {
                    { "CodAuc", contacto.CodAux},
                    { "NomCon", contacto.NomAux},
                    {"pv_BaseDatos",basedatos }

                });
                return UTIL.Mapper.BindDataList<ClientesModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<ClientesModels> AgregarContacto(ClientesModels contacto)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_AgregarContactos", new System.Collections.Hashtable()
                {
                    { "CodAux", contacto.CodAux},
                    { "NomCon", contacto.NomCon},
                });
                return UTIL.Mapper.BindDataList<ClientesModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<DireccionDespachoModels> BuscarDirecDespach(DireccionDespachoModels DirDes, string baseDatos)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_BuscarDirecDespa", new System.Collections.Hashtable()
                {
                    { "CodAxD", DirDes.CodAxD},
                    { "pv_BaseDatos", baseDatos},
                });
                return UTIL.Mapper.BindDataList<DireccionDespachoModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public RespuestaModel AgregarDireccionDespacho(DireccionDespachoModels DirDes, string baseDatos)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("DS_AgregarDireccionDespacho", new System.Collections.Hashtable()
                {
                    { "pv_CodAux", DirDes.CodAxD},
                    { "pv_DirDch", DirDes.DirDch},
                    { "pv_ComDch", DirDes.ComDch},
                    { "pv_NomDch", DirDes.NomDch},
                    { "pv_CiuDch", DirDes.CiuDch},
                    { "pv_BaseDatos", baseDatos},
                });
                return UTIL.Mapper.BindData<RespuestaModel>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public RespuestaModel ActualizarCliente(ClientesModels cliente, string basedatos)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_ActualizarCliente", new System.Collections.Hashtable()
                {
                    { "CodAux", cliente.CodAux},
                    { "RutAux", cliente.RutAux},
                    { "NomAux", cliente.NomAux},
                    { "DirAux", cliente.DirAux},
                    { "NomCon", cliente.NomCon},
                    { "FonCon", cliente.FonCon},
                    { "Email", cliente.EMail},
                    { "pv_BaseDatos", basedatos}
            });
                return UTIL.Mapper.BindData<RespuestaModel>(data);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }








        public List<CondicionVentasModels> listarConVen(string baseDatos, CondicionVentasModels conven)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_ListarCondicionesDeVenta", new System.Collections.Hashtable()
                {
                    { "CodAux", conven.CodAux},
                    { "pv_BaseDatos", baseDatos},
                });
                return UTIL.Mapper.BindDataList<CondicionVentasModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }
        public List<ListaDePrecioModels> listarListaDePrecio(string baseDatos, ListaDePrecioModels lista)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_ListarListaDePrecio", new System.Collections.Hashtable()
                {
                    { "CodAux", lista.CodAux},
                    { "pv_BaseDatos", baseDatos},
                });
                return UTIL.Mapper.BindDataList<ListaDePrecioModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public ObjetoUsuario Login(ObjetoUsuario datosUsuarios)
        {
            var DatosLogin = new ObjetoUsuario();
            var data = new DBConector().EjecutarProcedimientoAlmacenado("SP_GET_LOGIN", new System.Collections.Hashtable()
                                                                                            {
                                                                                                {"Nombre", datosUsuarios.Nombre},
                                                                                                {"Contrasena", datosUsuarios.Contrasena }
                                                                                            });

            if (data.Rows.Count > 0)
            {
                var validador = new object();

                validador = data.Rows[0].Field<object>("Id");
                DatosLogin.IdUsuario = validador != null ? data.Rows[0].Field<int>("Id") : 0;

                validador = data.Rows[0].Field<object>("Usuario");
                DatosLogin.Nombre = validador != null ? data.Rows[0].Field<string>("Usuario") : "NO ASIGNADO";

                validador = data.Rows[0].Field<object>("TipoUsuario");
                DatosLogin.TipoUsuario = validador != null ? data.Rows[0].Field<int>("TipoUsuario") : -1;
            }
            else
            {
                DatosLogin = null;
            }

            return DatosLogin;
        }

        public List<NotadeVentaCabeceraModels> AgregarNV(NotadeVentaCabeceraModels NVC)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_AgregarNVCabecera", new System.Collections.Hashtable()
                {
                    { "NVNumero", NVC.NVNumero},
                    { "NumOC", NVC.NumOC},
                    { "NumReq", NVC.NumReq},
                });
                return UTIL.Mapper.BindDataList<NotadeVentaCabeceraModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }

        }

        public List<NotadeVentaCabeceraModels> EditarNV(NotadeVentaCabeceraModels NVC)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_ModificarNVCabecera", new System.Collections.Hashtable()
                {
                    { "NVNumero", NVC.NVNumero},
                    { "nvFem", NVC.nvFem},
                    { "nvEstado", NVC.nvEstado},
                    { "nvEstFact", NVC.nvEstFact},
                    { "nvEstDesp", NVC.nvEstDesp},
                    { "nvEstRese", NVC.nvEstRese},
                    { "nvEstConc", NVC.nvEstConc},
                    { "nvFeEnt", NVC.nvFeEnt},
                    { "CodAux", NVC.CodAux},
                    { "VenCod", NVC.VenCod},
                    { "CodMon", NVC.CodMon},
                    { "CodLista", NVC.CodLista},
                    { "nvObser", NVC.nvObser},
                    { "CveCod", NVC.CveCod},
                    { "NomCon", NVC.NomCon},
                    { "CodiCC", NVC.CodiCC},
                    { "nvSubTotal", NVC.nvSubTotal},
                    { "nvPorcDesc01", NVC.nvPorcDesc01},
                    { "nvDescto01", NVC.nvDescto01},
                    { "nvPorcDesc02", NVC.nvPorcDesc02},
                    { "nvDescto02", NVC.nvDescto02},
                    { "nvPorcDesc03", NVC.nvPorcDesc03},
                    { "nvDescto03", NVC.nvDescto03},
                    { "nvPorcDesc04", NVC.nvPorcDesc04},
                    { "nvDescto04", NVC.nvDescto04},
                    { "nvPorcDesc05", NVC.nvPorcDesc05},
                    { "nvDescto05", NVC.nvDescto05},
                    { "nvMonto", NVC.nvMonto},
                    { "NumGuiaRes", NVC.NumGuiaRes},
                    { "nvPorcFlete", NVC.nvPorcFlete},
                    { "nvValflete", NVC.nvValflete},
                    { "nvPorcEmb", NVC.nvPorcEmb},
                    { "nvEquiv", NVC.nvEquiv},
                    { "nvNetoExento", NVC.nvNetoExento},
                    { "nvNetoAfecto", NVC.nvNetoAfecto},
                    { "nvTotalDesc", NVC.nvTotalDesc},
                    { "ConcAuto", NVC.ConcAuto},
                    { "CheckeoPorAlarmaVtas", NVC.CheckeoPorAlarmaVtas},
                    { "EnMantencion", NVC.EnMantencion},
                    { "Usuario", NVC.Usuario},
                    { "UsuarioGeneraDocto", NVC.UsuarioGeneraDocto},
                    { "FechaHoraCreacion", NVC.FechaHoraCreacion},
                    { "Sistema", NVC.Sistema},
                    { "ConcManual", NVC.ConcManual},
                    { "proceso", NVC.proceso},
                    { "TotalBoleta", NVC.TotalBoleta},
                    { "NumReq", NVC.NumReq},
                    { "CodVenWeb", NVC.CodVenWeb},
                    { "EstadoNP", NVC.EstadoNP},
                    { "CodLugarDesp", NVC.CodLugarDesp},
                });
                return UTIL.Mapper.BindDataList<NotadeVentaCabeceraModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                throw ex;
            }

        }

        public List<NotaDeVentaDetalleModels> DetalleNV(NotaDeVentaDetalleModels NVD)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_AgregarNVDetalle", new System.Collections.Hashtable()
                {
                    { "NVNumero", NVD.NVNumero},
                    { "nvLinea", NVD.nvLinea},
                    { "nvCorrela", NVD.nvCorrela},
                    { "nvFecCompr", NVD.nvFecCompr},
                    { "CodProd", NVD.CodProd},
                    { "nvCant", NVD.nvCant},
                    { "nvPrecio", NVD.nvPrecio},
                    { "nvEquiv", NVD.nvEquiv},
                    { "nvSubTotal", NVD.nvSubTotal},
                    { "nvDPorcDesc01", NVD.nvDPorcDesc01},
                    { "nvDDescto01", NVD.nvDDescto01},
                    { "nvDPorcDesc02", NVD.nvDPorcDesc02},
                    { "nvDDescto02", NVD.nvDDescto02},
                    { "nvDPorcDesc03", NVD.nvDPorcDesc03},
                    { "nvDDescto03", NVD.nvDDescto03},
                    { "nvDPorcDesc04", NVD.nvDPorcDesc04},
                    { "nvDDescto04", NVD.nvDDescto04},
                    { "nvDPorcDesc05", NVD.nvDPorcDesc05},
                    { "nvDDescto05", NVD.nvDDescto05},
                    { "nvTotDesc", NVD.nvTotDesc},
                    { "nvTotLinea", NVD.nvTotLinea},
                    { "nvCantDesp", NVD.nvCantDesp},
                    { "nvCantProd", NVD.nvCantProd},
                    { "nvCantFact", NVD.nvCantFact},
                    { "nvCantDevuelto", NVD.nvCantDevuelto},
                    { "nvCantNC", NVD.nvCantNC},
                    { "nvCantBoleta", NVD.nvCantBoleta},
                    { "nvCantOC", NVD.nvCantOC},
                    { "DetProd", NVD.DetProd},
                    { "CheckeoMovporAlarmaVtas", NVD.CheckeoMovporAlarmaVtas},
                    { "KIT", NVD.KIT},
                    { "CodPromocion", NVD.CodPromocion},
                    { "CodUMed", NVD.CodUMed},
                    { "CantUVta", NVD.CantUVta},
                    { "Partida", NVD.Partida},
                    { "Pieza", NVD.Pieza},
                });
                return UTIL.Mapper.BindDataList<NotaDeVentaDetalleModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<NotadeVentaCabeceraModels> BuscarNVPorNumero(NotadeVentaCabeceraModels NVC)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("JS_ListarNVNM", new System.Collections.Hashtable()
                {
                    { "intNVNumero", NVC.NVNumero},
                });
                return UTIL.Mapper.BindDataList<NotadeVentaCabeceraModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }

        }

        public List<NotadeVentaCabeceraModels> BuscarNVNum(NotadeVentaCabeceraModels NVSoft)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("SP_GET_BuscaNVNumSoft", new System.Collections.Hashtable()
                {
                    { "NVNum", NVSoft.NVNumero},
                });
                return UTIL.Mapper.BindDataList<NotadeVentaCabeceraModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }

        }

        public List<NotaDeVentaDetalleModels> BuscarNVDETALLEPorNumero(NotadeVentaCabeceraModels NVC)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("JS_ListarNVDETALLENM", new System.Collections.Hashtable()
                {
                    { "intNVNumero", NVC.NVNumero},
                });
                return UTIL.Mapper.BindDataList<NotaDeVentaDetalleModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }

        }

        public List<NotadeVentaCabeceraModels> InsertarNvSoftland(NotadeVentaCabeceraModels NVC)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("insertaNVSoftland", new System.Collections.Hashtable()
                {
                    { "nvNumero", NVC.NVNumero},
                });
                return UTIL.Mapper.BindDataList<NotadeVentaCabeceraModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }

        }
        public ParametrosModels BuscarParametros(int idEmpresa)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_BuscarParametrosUsuarios", new System.Collections.Hashtable()
                {
                    { "pi_idEmpresa", idEmpresa},
                });
                return UTIL.Mapper.BindData<ParametrosModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public RespuestaModel ModificarParametros(ParametrosModels parametro)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_ModificarParametrosUsuarios", new System.Collections.Hashtable()
                {
                    { "pi_IdEmpresa", parametro.IdEmpresa},
                    { "pb_MultiEmpresa", parametro.MultiEmpresa},
                    { "pb_ManejaAdministrador", parametro.ManejaAdministrador},
                    { "pb_ManejaAprobador", parametro.ManejaAprobador},
                    { "pb_ListaClientesVendedor", parametro.ListaClientesVendedor},
                    { "pb_ListaClientesTodos", parametro.ListaClientesTodos},
                    { "pb_ValidaReglasNegocio", parametro.ValidaReglasNegocio},
                    { "pb_ManejaListaPrecios", parametro.ManejaListaPrecios},
                    { "pb_EditaPrecioProducto", parametro.EditaPrecioProducto},
                    { "pb_MuestraCondicionVentaCliente", parametro.MuestraCondicionVentaCliente},
                    { "pb_MuestraCondicionVentaTodos", parametro.MuestraCondicionVentaTodos},
                    { "pb_EditaDescuentoProducto", parametro.EditaDescuentoProducto},
                    { "pd_MaximoDescuentoProducto", parametro.MaximoDescuentoProducto},
                    { "pb_CantidadDescuentosProducto", parametro.CantidadDescuentosProducto},
                    { "pb_MuestraStockProducto", parametro.MuestraStockProducto},
                    { "pb_StockProductoEsMasivo", parametro.StockProductoEsMasivo},
                    { "pb_StockProductoEsBodega", parametro.StockProductoEsBodega},
                    { "pv_StockProductoCodigoBodega", parametro.StockProductoCodigoBodega},
                    { "pb_ControlaStockProducto", parametro.ControlaStockProducto},
                    { "pb_EnvioMailCliente", parametro.EnvioMailCliente},
                    { "pb_EnvioMailVendedor", parametro.EnvioMailVendedor},
                    { "pb_EnvioMailContacto", parametro.EnvioMailContacto},
                    { "pb_EnvioObligatorioAprobador", parametro.EnvioObligatorioAprobador},
                    { "pb_ManejaTallaColor", parametro.ManejaTallaColor},
                    { "pb_ManejaDescuentoTotalDocumento", parametro.ManejaDescuentoTotalDocumento},
                    { "pi_CantidadDescuentosTotalDocumento", parametro.CantidadDescuentosTotalDocumento},
                    { "pi_CantidadLineas", parametro.CantidadLineas},
                    { "pb_ManejaLineaCredito", parametro.ManejaLineaCredito},
                    { "pb_ManejaCanalVenta", parametro.ManejaCanalVenta},
                    { "pb_CreacionNotaVentaUsuariosBloqueados", parametro.CreacionNotaVentaUsuariosBloqueados},
                    { "pb_CreacionNotaVentaUsuariosInactivos", parametro.CreacionNotaVentaUsuariosInactivos},
                    { "pb_PermiteModificacionCondicionVenta", parametro.PermiteModificacionCondicionVenta},
                    { "pv_AtributoSoftlandDescuentoCliente", parametro.AtributoSoftlandDescuentoCliente},
                    { "pb_PermiteCrearDireccion", parametro.PermiteCrearDireccion},
                    { "pb_CrearClienteConDV", parametro.CrearClienteConDV},
                });
                return UTIL.Mapper.BindData<RespuestaModel>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }
        public List<ProductosModels> BuscarProducto(ProductosModels producto)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_BuscarProducto", new System.Collections.Hashtable()
                {
                    { "DesProd", producto.DesProd},
                    { "CodLista", producto.CodLista},
                });
                return UTIL.Mapper.BindDataList<ProductosModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }
        public List<ProductosModels> ListarProducto(string ListaPrecio, string baseDatos)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_ListaProductos", new System.Collections.Hashtable()
                {
                    { "pv_ListaProductos", ListaPrecio},
                    { "pv_BaseDatos", baseDatos},
                });
                return UTIL.Mapper.BindDataList<ProductosModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }
        public List<TallaColorProductoModels> ListarTallaColorProducto(string CodProd, string baseDatos)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_ListaTallaColorProducto", new System.Collections.Hashtable()
                {
                    { "@pv_CodProd", CodProd},
                    { "@pv_BaseDatos", baseDatos},
                });
                return UTIL.Mapper.BindDataList<TallaColorProductoModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<ProductosModels> BuscarProductoRapido(ProductosModels producto)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_BuscarProductoRapido", new System.Collections.Hashtable()
                {
                    { "CodRapido", producto.CodRapido},
                    { "CodLista", producto.CodLista},
                });
                return UTIL.Mapper.BindDataList<ProductosModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<NotadeVentaCabeceraModels> listarDocAprobados()
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_ListarDocumentosAprobados", new System.Collections.Hashtable()
                {
                });
                return UTIL.Mapper.BindDataList<NotadeVentaCabeceraModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<NotadeVentaCabeceraModels> listarDocPendientes()
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_ListarDocumentosPendientes", new System.Collections.Hashtable()
                {
                });
                return UTIL.Mapper.BindDataList<NotadeVentaCabeceraModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<NotadeVentaCabeceraModels> actualizaEstado(NotadeVentaCabeceraModels nw)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("RRA_ActualizaEstadoNW", new System.Collections.Hashtable()
                {
                    { "nvNumero", nw.NVNumero},
                });
                return UTIL.Mapper.BindDataList<NotadeVentaCabeceraModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<NotadeVentaCabeceraModels> BuscarNVC(NotadeVentaCabeceraModels nw)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_BuscarNVCabecera", new System.Collections.Hashtable()
                {
                    { "nvNumero", nw.NVNumero},
                });
                return UTIL.Mapper.BindDataList<NotadeVentaCabeceraModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<NotaDeVentaDetalleModels> BuscarNVD(NotaDeVentaDetalleModels nw)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_BuscarNVDetalle", new System.Collections.Hashtable()
                {
                    { "nvNumero", nw.NVNumero},
                });
                return UTIL.Mapper.BindDataList<NotaDeVentaDetalleModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<NotaDeVentaDetalleModels> ListarNotaDetalle(NotaDeVentaDetalleModels nw)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_ListarNVDetalleStock", new System.Collections.Hashtable()
                {
                    { "nvNumero", nw.NVNumero},
                });
                return UTIL.Mapper.BindDataList<NotaDeVentaDetalleModels>(data);


            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<UsuariosModels> listarUsuarios()
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_ListarUsuarios", new System.Collections.Hashtable()
                {
                });
                return UTIL.Mapper.BindDataList<UsuariosModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<UsuariosModels> BuscarUsuario(UsuariosModels usuario)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_BuscarUsuarios", new System.Collections.Hashtable()
                {
                    { "id", usuario.id},
                });
                return UTIL.Mapper.BindDataList<UsuariosModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public RespuestaModel ActualizarUsuario(UsuariosModels usuario)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_ActualizarUsuario", new System.Collections.Hashtable()
                {
                    { "id", usuario.id},
                    { "usuario", usuario.Usuario},
                    { "email", usuario.email},
                    { "tipoUsuario", usuario.tipoUsuario},
                    { "venCod", usuario.VenCod},
                });
                return UTIL.Mapper.BindData<RespuestaModel>(data);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public RespuestaModel AgregarUsuario(UsuariosModels usuario)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_AgregarUsuario", new System.Collections.Hashtable()
                {
                    { "Usuario", usuario.Usuario},
                    { "email", usuario.email},
                    { "tipoUsuario", usuario.tipoUsuario},
                    { "VenCod", usuario.VenCod },
                    { "Contrasena", usuario.Password },
                    { "Nombre", usuario.Nombre },
                    { "BaseDatos", usuario.BaseDatos},
                });

                return UTIL.Mapper.BindData<RespuestaModel>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public RespuestaModel EliminarUsuario(UsuariosModels usuarios)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_EliminarUsuario", new System.Collections.Hashtable()
                {
                    { "Id", usuarios.id},
                });
                return UTIL.Mapper.BindData<RespuestaModel>(data);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public RespuestaModel EditarUsuario(UsuariosModels usuarios)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("DS_SET_EditarUsuario", new System.Collections.Hashtable()
                {
                    {"@IdUsuario",usuarios.id },
                    {"@Usuario",usuarios.Usuario },
                    {"@Nombre",usuarios.Nombre },
                    {"@Password",usuarios.Password },
                    {"@Email",usuarios.email },
                    {"@TipoUsuario",int.Parse(usuarios.tipoUsuario) },
                    {"@VendCod",usuarios.VenCod }
                });
                return UTIL.Mapper.BindData<RespuestaModel>(data);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<UsuariosTiposModels> listarTipo()
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_ListarUsuariosTipos", new System.Collections.Hashtable()
                {
                });
                return UTIL.Mapper.BindDataList<UsuariosTiposModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }
        public List<VendedoresSoftlandModels> ListarVendedoresSoftland(string venCod)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_ListarVendedorSoftland", new System.Collections.Hashtable()
                {
                    { "venCod", venCod},
                });
                return UTIL.Mapper.BindDataList<VendedoresSoftlandModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<VendedoresSoftlandModels> listarVendedoresSoftland(string basedatos)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("FR_ListarVendedorSoftland2", new System.Collections.Hashtable()
                {
                    {"pv_BaseDatos",basedatos }
                });
                return UTIL.Mapper.BindDataList<VendedoresSoftlandModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<ObjetoPerfil> ListarPerfiles()
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("DS_ListarPefiles", new System.Collections.Hashtable()
                {
                });
                return UTIL.Mapper.BindDataList<ObjetoPerfil>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<UsuariosModels> ListarCodVendedorSoft(string basedatos)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("SP_GetCodVendedor", new System.Collections.Hashtable()
                {
                    {"pv_BaseDatos",basedatos }
                });
                return UTIL.Mapper.BindDataList<UsuariosModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }


        public List<ClientesModels> GetVendedores(string basedatos, ClientesModels cliente = null)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("JS_ListarVendorVenCod", new System.Collections.Hashtable()
                {
                    { "VenCod", cliente.VenCod},
                    {"pv_BaseDatos",basedatos }
                });
                return UTIL.Mapper.BindDataList<ClientesModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<UsuariosModels> GetDatosUsuario(string Id, string basedatos)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("DS_GET_ObtenerDatosUsuario", new System.Collections.Hashtable()
                {
                    {"IdUsuario", int.Parse(Id) },
                    {"pv_BaseDatos",basedatos }
                });
                return UTIL.Mapper.BindDataList<UsuariosModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<ClientesModels> GetDatosClientes(string CodAux, string basedatos)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("DS_GET_ObtenerDatosCliente", new System.Collections.Hashtable()
                {
                    {"CodAux",CodAux },
                    {"pv_BaseDatos",basedatos }
                });
                return UTIL.Mapper.BindDataList<ClientesModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<UsuarioEmpresaModel> ListaUsuarioEmpresas(int idUsuario)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("DS_ListaUsuarioEmpresa", new System.Collections.Hashtable()
                {
                    { "pi_IdUsuario", idUsuario},
                });
                return UTIL.Mapper.BindDataList<UsuarioEmpresaModel>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<ClientesModels> ObtenerGiro(string basedatos)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("SP_GET_Giro", new System.Collections.Hashtable()
                {
                    {"pv_BaseDatos",basedatos }
                });
                return UTIL.Mapper.BindDataList<ClientesModels>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }

        }

        public List<CiudadModel> ObtenerCiudad(string baseDatos)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("SP_GET_Ciudad", new System.Collections.Hashtable()
                {
                    { "pv_BaseDatos", baseDatos},
                });
                return UTIL.Mapper.BindDataList<CiudadModel>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }

        public List<ComunaModel> ObtenerComuna(string baseDatos)
        {
            try
            {
                var data = new DBConector().EjecutarProcedimientoAlmacenado("SP_GET_Comuna", new System.Collections.Hashtable()
                {
                    { "pv_BaseDatos", baseDatos},
                });
                return UTIL.Mapper.BindDataList<ComunaModel>(data);
            }
            catch (Exception ex)
            {
                string error = ex.ToString();
                return null;
            }
        }


    }
}