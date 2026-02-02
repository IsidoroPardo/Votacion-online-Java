/*
*/
package modelos;

import java.util.ArrayList;

/**
 *
 * @author isido
 */
public class ConteoVotos {
    private ArrayList<Recuento> ConteoVotos;
    
    public ConteoVotos(){
        this.ConteoVotos = new ArrayList();
    }
    
    public void addRecuento(Recuento papeleta){
        this.ConteoVotos.add(papeleta);
    }
    
    public Recuento getRecuento(int index){
        return ConteoVotos.get(index);
    }
    
    public int getVotosPartido(String partido){
        int votos=0;
        for (int i = 0; i < this.ConteoVotos.size(); i++) {
            if ((this.ConteoVotos.get(i).getPartido()).equals(partido)) {
                votos = this.ConteoVotos.get(i).getVotos();
            }
        }
        return votos;
    }
    
    /*public String getPartidoMasVotado(){
        ArrayList<Recuento> auxiliar = new ArrayList();
        // ordenamiento por algoritmo burbuja
        // Repetimos el procesos n-1 veces para un arreglo de tamaño n.
        
        for(int i=0; i < this.ConteoVotos.size(); i++){
            String partido = "";
            for (int j = 0; j < this.ConteoVotos.size()-1; j++) {
                
            }
        }
        //auxiliar.add(i, aux);
        
    }*/
    
    
}
