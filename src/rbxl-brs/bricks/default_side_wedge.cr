module RBXLBRS
  class DefaultSideWedge < Part
    def write_xml(xml : XML::Builder)
      xml.element "Item", {"class" => "WedgePart"} do
        xml.element "Properties" do
          write_anchored(xml)
          write_size(xml, @brick.size.z / 5, @brick.size.x / 5, @brick.size.y / 5)
          (cframe(apply_angle: false) * CFrame.angles(0, (rotation + 2) * Math::PI / 2, 0) * CFrame.angles(0, 0, Math::PI / 2)).write_xml(xml)
          write_color(xml)

          xml.element "token", name: "TopSurface" { xml.text "0" }
          xml.element "token", name: "BottomSurface" { xml.text "0" }
          xml.element "token", name: "LeftSurface" { xml.text "4" }
          xml.element "token", name: "RightSurface" { xml.text "3" }
        end
      end
    end
  end
end
