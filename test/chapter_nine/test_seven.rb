require 'config_test'

module ChapterNine
  class TestSeven < Minitest::Test
    include Seven

    def test_fills_surrounding_paint
      screen = [%i[r r r r r],
                %i[r b b b r],
                %i[r b r r r],
                %i[r b b r r],
                %i[r r r r r]]

      expected = [%i[g g g g g],
                  %i[g b b b g],
                  %i[g b g g g],
                  %i[g b b g g],
                  %i[g g g g g]]

      paint_fill([0, 0], :g, screen)
      assert_equal expected, screen
    end

    def test_fills_only_surrounding_and_connected_paint
      screen = [%i[r r r r r],
                %i[r b b b r],
                %i[r b r b r],
                %i[r b b r r],
                %i[r r r r r]]

      expected = [%i[g g g g g],
                  %i[g b b b g],
                  %i[g b r b g],
                  %i[g b b g g],
                  %i[g g g g g]]

      paint_fill([3, 3], :g, screen)
      assert_equal expected, screen

    end

    def test_does_nothing_if_point_is_already_color_specified
      screen = [%i[r r r r r],
                %i[r b b r r],
                %i[r b r r r],
                %i[r r r r r],
                %i[r r r r r]]

      expected = Marshal.load(Marshal.dump(screen))

      paint_fill([0, 0], :r, screen)
      assert_equal expected, screen
    end

  end
end
