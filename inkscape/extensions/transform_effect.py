import inkex
from inkex.transforms import Transform

class TransformEffect(inkex.EffectExtension):
    def add_arguments(self, pars):
        pars.add_argument("--copies", type=int, default=10)
        pars.add_argument("--move_x", type=float, default=0.0)
        pars.add_argument("--move_y", type=float, default=0.0)
        pars.add_argument("--scale", type=float, default=100.0)
        pars.add_argument("--rotate", type=float, default=0.0)
        pars.add_argument("--anchor", type=str, default="bottom-left")
        pars.add_argument("--reflect_x", type=inkex.Boolean, default=False)
        pars.add_argument("--reflect_y", type=inkex.Boolean, default=False)

    def get_anchor_point(self, bbox, anchor_type):
        x_min, x_max = bbox.left, bbox.right
        y_min, y_max = bbox.top, bbox.bottom
        x_mid, y_mid = bbox.center.x, bbox.center.y

        anchors = {
            "top-left": (x_min, y_min),
            "top-center": (x_mid, y_min),
            "top-right": (x_max, y_min),
            "center-left": (x_min, y_mid),
            "center": (x_mid, y_mid),
            "center-right": (x_max, y_mid),
            "bottom-left": (x_min, y_max),
            "bottom-center": (x_mid, y_max),
            "bottom-right": (x_max, y_max),
        }
        return anchors.get(anchor_type, (x_mid, y_mid))

    def effect(self):
        if not self.svg.selection:
            inkex.errormsg("Por favor, selecione pelo menos um objeto!")
            return

        copies = self.options.copies
        dx = self.options.move_x
        dy = self.options.move_y
        scale_factor = self.options.scale / 100.0
        angle = self.options.rotate
        reflect_x = -1.0 if self.options.reflect_x else 1.0
        reflect_y = -1.0 if self.options.reflect_y else 1.0

        for elem in list(self.svg.selection.values()):
            bbox = elem.bounding_box()
            if bbox is None:
                continue

            cx, cy = self.get_anchor_point(bbox, self.options.anchor)
            parent = elem.getparent()
            last_elem = elem

            for i in range(1, copies + 1):
                new_elem = last_elem.copy()

                # Monta a matriz de transformação no ponto de ancoragem selecionado
                t = Transform()
                t.add_translate(cx + (dx * i), cy + (dy * i))
                t.add_rotate(angle * i)
                
                # Aplica a escala + espelhamento (reflect) acumulados
                sx = (scale_factor ** i) * (reflect_x if i % 2 != 0 else 1.0)
                sy = (scale_factor ** i) * (reflect_y if i % 2 != 0 else 1.0)
                t.add_scale(sx, sy)
                
                t.add_translate(-cx, -cy)

                new_elem.transform = elem.transform @ t
                parent.append(new_elem)

if __name__ == '__main__':
    TransformEffect().run()