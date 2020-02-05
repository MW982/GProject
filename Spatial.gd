extends RigidBody


const GRENADE_DAMAGE = 60

const GRENADE_TIME = 2
var grenade_timer = 0

const EXPLOSION_WAIT_TIME = 0.98
var explosion_wait_timer = 0

var rigid_shape
var grenade_mesh
var blast_area
var explosion_particles
var light

func _ready():
    rigid_shape = $Collision_Shape
    grenade_mesh = $Grenade
    blast_area = $Blast_Area
    explosion_particles = $Explosion
    light = $OmniLight

    explosion_particles.emitting = false
    explosion_particles.one_shot = true

func _process(delta):

    if grenade_timer < GRENADE_TIME:
        grenade_timer += delta
        return
    else:
        if explosion_wait_timer <= 0:
            $AudioStreamPlayer3D.play()
            explosion_particles.emitting = true
            light.light_energy = 1

            grenade_mesh.visible = false
            rigid_shape.disabled = true

            mode = RigidBody.MODE_STATIC

            var bodies = blast_area.get_overlapping_bodies()
            for body in bodies:
                if body.has_method("damage"):
                    body.damage(GRENADE_DAMAGE)

            # This would be the perfect place to play a sound!


        if explosion_wait_timer < EXPLOSION_WAIT_TIME:
            if explosion_wait_timer < EXPLOSION_WAIT_TIME/2:
                 light.light_energy += 0.5
            else:
                 light.light_energy -= 0.7
            explosion_wait_timer += delta

            if explosion_wait_timer >= EXPLOSION_WAIT_TIME:
                queue_free()