using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class classes : MonoBehaviour
{
    public class t_perso
    {
        public string name;
        public int life;
        public float speed_move;
        // public float speed_jump;

        /* public int att_B;
        public int att_B_LR;
        public int att_B_Down;
        public int att_B_Up;
        public int att_Combo;
        public int att_A_Dash;
        public int att_Smash_LR;
        public int att_Smash_Up;
        public int att_Smash_Down;
        public int att_Ultimate;
        
        public int alt_Freeze;
        public int alt_Burn;
        public int alt_Bleeding;
        public int alt_paralysis;
        public int alt_Confusion;

        public Animation taunt_normal;
        public Animation taunt_special; */

        public t_perso(string nom, int pv,float smove)
        {
            name = nom;
            life = pv;
            speed_move = smove;
        }

        public t_perso()
        {
            name = " ";
            life = 0;
            speed_move = 0;
        }

    }
}