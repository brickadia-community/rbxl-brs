module RBXLBRS
  class Round < Part
    def initialize(@save, @brick, @diameter : Float64, @height : Float64)
      initialize(@save, @brick)
    end

    def write_xml(xml : XML::Builder)
      xml.element "Item", {"class" => "Part"} do
        xml.element "Properties" do
          write_anchored(xml)
          write_size(xml, @height, @diameter, @diameter)
          (cframe * CFrame.angles(0.0, 0.0, Math::PI / 2)).write_xml(xml)
          write_color(xml)

          xml.element "token", name: "Shape" { xml.text "2" }
          xml.element "token", name: "TopSurface" { xml.text "0" }
          xml.element "token", name: "BottomSurface" { xml.text "0" }
          xml.element "token", name: "RightSurface" { xml.text "3" }
          xml.element "token", name: "LeftSurface" { xml.text "4" }
        end
      end
    end
  end
end
