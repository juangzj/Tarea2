package com.mycompany.mundo;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletContext;

public class Archivos {

    public static void escribirArchivo(ArrayList<Usuario> misUsuarios, ServletContext context) throws FileNotFoundException {
        // Ruta relativa y absoluta del archivo de datos serializados
        String rutaRelativa = "/data/usuariosAgregados.txt";
        String rutaAbsoluta = context.getRealPath(rutaRelativa);
        File archivo = new File(rutaAbsoluta);

        try (PrintWriter pluma = new PrintWriter(archivo)) {
            // Ciclo for que recorre los datos del arrayList llamado misUsuarios
            for (Usuario usuario : misUsuarios) {
                String cadenaCaracteres = usuario.getCedula() + "," + usuario.getNombre() + "," + usuario.getContrasenia();
                pluma.write(cadenaCaracteres);
                pluma.write("\n");
            }
            pluma.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public static void leerArchivo(ArrayList<Usuario> misUsuarios, ServletContext context) throws FileNotFoundException, IOException {

        // Ruta relativa y absoluta del archivo de datos serializados
        String rutaRelativa = "/data/usuariosAgregados.txt";
        String rutaAbsoluta = context.getRealPath(rutaRelativa);
        File archivo = new File(rutaAbsoluta);

        try (FileReader fr = new FileReader(archivo); BufferedReader lector = new BufferedReader(fr)) {

            String cadenaCaracteres;

            while ((cadenaCaracteres = lector.readLine()) != null) {
                String[] datos = cadenaCaracteres.split(",");

                String cedula = datos[0].trim();
                String nombre = datos[1].trim();
                String contrasenia = datos[2].trim();

                // Crear un objeto Usuario con los datos leídos y agregarlo a la lista
                Usuario usuario = new Usuario(Integer.parseInt(cedula), nombre, contrasenia);
                misUsuarios.add(usuario);
            }

        } catch (FileNotFoundException e) {
            System.out.println(e.getMessage());
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }

    public static void escribirArchivoTareas(ListasEnlazadas listaEnlazada, ServletContext context) throws FileNotFoundException {
        // Ruta relativa y absoluta del archivo de datos serializados
        String rutaRelativa = "/data/tareas.txt";
        String rutaAbsoluta = context.getRealPath(rutaRelativa);
        File archivo = new File(rutaAbsoluta);

        try (FileOutputStream fos = new FileOutputStream(archivo); ObjectOutputStream oos = new ObjectOutputStream(fos)) {
            oos.writeObject(listaEnlazada);
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }

    public static ListasEnlazadas leerArchivoTareas(ServletContext context) throws FileNotFoundException, ClassNotFoundException {
        // Implementación del método para leer el archivo y deserializar la lista enlazada
        ListasEnlazadas listaEnlazada = null;
        // Ruta relativa y absoluta del archivo de datos serializados
        String rutaRelativa = "/data/tareas.txt";
        String rutaAbsoluta = context.getRealPath(rutaRelativa);
        File archivo = new File(rutaAbsoluta);

        try (FileInputStream fis = new FileInputStream(archivo); ObjectInputStream ois = new ObjectInputStream(fis)) {
            listaEnlazada = (ListasEnlazadas) ois.readObject();
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }

        return listaEnlazada;
    }

}
