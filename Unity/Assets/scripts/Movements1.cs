using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using static SelectCharacter;
using static perso1;

public class Movements1 : MonoBehaviour
{
    public Transform attaque_trigger;
    public GameObject Dammages_zone;

    public CharacterController2D controller;

    public float runspeed;
    float horizontalMove = 0f;
    bool jump = false;

    private void Start()
    {
        if (Persotest1Enable == true)
        {
            runspeed = persotest1.speed_move;
        }

        if (Persotest2Enable == true)
        {
            runspeed = persotest2.speed_move;
        }
    }

    // Update is called once per frame
    void Update()
    {
        horizontalMove = Input.GetAxisRaw("Horizontal") * runspeed;

        if (Input.GetButtonDown("Jump"))
        {
            jump = true;
        }

        if (Input.GetButtonDown("Fire1")) {
            if (horizontalMove != 0f)
            {
                attack();
            }
        }
    }

    private void FixedUpdate()
    {
        controller.Move(horizontalMove * Time.fixedDeltaTime, false, jump);
        jump = false;
    }

    void attack()
    {
        Instantiate(Dammages_zone, attaque_trigger.position, attaque_trigger.rotation);
    }
    
}
